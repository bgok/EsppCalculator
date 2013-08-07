angular.module('EsppCalculator.services', [])
    .value 'initialData',
        startingPrice: 14
        endingPrice: 25
        annualSalary: 80000
        payPeriodsPerYear: 24
        payPeriodsInOffering: 15
        investmentPercentage: 15
        strikePriceDiscount: 15
        taxRate: .25
        maxSharesPerPeriod: 1200

angular.module('EsppCalculator.app', ['EsppCalculator.services'])
#    .config(($stateProvider) ->
#        $stateProvider.state('calculator',
#            url: '/calculator'
#            views:
#                main:
#                    controller: 'EsppCalculator.controller'
#                    templateUrl: 'calculator/calculator.tpl.html'
#            )
#        )
    .controller(($scope, initialData) ->
        data = $scope.data = initialData

        _.extend $scope,
            getStrikePrice: ->
                Math.min(data.startingPrice, data.endingPrice) * (100 - data.strikePriceDiscount) / 100
            getSalaryPerPayPeriod: ->
                data.annualSalary / data.payPeriodsPerYear
            getInvestmentPerPeriod: ->
                $scope.getSalaryPerPayPeriod() * data.investmentPercentage / 100
            getInvestmentAmount: ->
                $scope.getInvestmentPerPeriod() * data.payPeriodsInOffering
            getSharesPurchased: ->
                Math.floor(data.maxSharesPerPeriod, Math.floor($scope.getInvestmentAmount() / $scope.getStrikePrice()))
            getGrossProfitPerShare: ->
                data.endingPrice - $scope.getStrikePrice()
            getNetProfitPerShare: ->
                $scope.getGrossProfitPerShare() - $scope.getTaxPerShare()
            getGrossProfit: ->
                $scope.getSharesPurchased() * $scope.getGrossProfitPerShare()
            getTaxPerShare: ->
                $scope.getGrossProfitPerShare() * data.taxRate
            getTaxOnTotal: ->
                $scope.getSharesPurchased() * $scope.getTaxPerShare()
            getTotalValue: ->
                data.endingPrice * $scope.getSharesPurchased()
            getNetProfit: ->
                $scope.getGrossProfit() - $scope.getTaxOnTotal()

        titleService.setTitle "Calculator"
    )
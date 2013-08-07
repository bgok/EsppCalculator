'use strict';

angular.module('ngBoilerplate', [
        'templates-app',
        'templates-common',
        'ngBoilerplate.home',
        'ngBoilerplate.about',
        'ui.state',
        'ui.route'
    ])

    .config(function myAppConfig($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.otherwise('/calculator');
    })

    .run(function run(titleService) {
        titleService.setSuffix(' | ESPP Calculator');
    })

    .controller('AppCtrl', function ($scope) {
        $scope.features = [
            'Angular',
            'Grunt',
            'SASS',
            'TDD, because it is the only way.',
            'Full Bower Integration'
        ];
    });


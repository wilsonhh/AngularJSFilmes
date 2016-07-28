angular.module("filmes").directive("awFilme2", function () {
  return {
    restrict: "A",
    scope: {
      filme: '=awFilme2',
      fnFechar: '&'
    },
    templateUrl: "templates/filme.template.html",
    link: function (scope, element, attr) {
      element.addClass('filme com-cartaz');

      if (!attr.fnFechar) {
        element.find('button').remove();
      }
    }
  };
})
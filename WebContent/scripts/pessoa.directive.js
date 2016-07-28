angular.module("myApp").directive("awPessoa", function () {
  return {
    restrict: "A",
    scope: {
      pessoa: '=awPessoa',
      fnRemove: '&',
      fnEditar: '&'
    },
    templateUrl: "templates/pessoa.template.html"
  };
})


 



(function(){
  angular.module('myApp').controller('customersCtrl', function($scope, ListaPessoas) {
	  $scope.pessoas = [];
	  $scope.countries = [];
	  
	// pagination
	  $scope.curPage = 0;
	  $scope.pageSize = 5;
	  
	  $scope.numberOfPages = function() 
	  {
	  return Math.ceil($scope.pessoas.length / $scope.pageSize);
	  };

	    var carregarPessoas = function(){
	    	ListaPessoas.listar().then(function(pessoas){
	        $scope.pessoas = pessoas;
	        
	      });
	    }	    
	    
	    var carregarCountries = function(){
	    	ListaPessoas.listarCountry().then(function(countries){
	        $scope.countries = countries;
	        
	      });
	    }	    
	    		      
	    $scope.removerPessoa = function(id) {
	    	ListaPessoas.remover(id).then(carregarPessoas);
	    }
	    
	    $scope.criarPessoa = function() {
	    	var pessoa = {
	    			id: $scope.novaPessoa.id,
	    			name: $scope.novaPessoa.name,
	    			country: $scope.novaPessoa.country
	    	};
	    	
	    	ListaPessoas.inserir(pessoa).then(carregarPessoas);	    

	        $scope.novaPessoa = {};
	    }
	    
	    $scope.editarPessoa = function(pessoa) {
	    	$scope.novaPessoa = pessoa;
	    } 
	    
	    $scope.limparPessoa = function() {	

	    	$scope.novaPessoa = {};
	    }
	    
	    $scope.propertyName = 'name';
	    $scope.reverse = true;

	    $scope.sortBy = function(propertyName) {
	      $scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
	      $scope.propertyName = propertyName;
	    };

	    carregarPessoas();
	    carregarCountries();

  });
  angular.module('myApp').filter('pagination', function()
		  {
		   return function(input, start)
		   {
		    start = +start;
		    return input.slice(start);
		   };
		  });
}

)();

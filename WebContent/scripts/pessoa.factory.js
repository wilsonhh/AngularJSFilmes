angular.module("myApp").factory("ListaPessoas", function($q, $http){
	return {
		listar: function() {
			var promessa = $q.defer();

			$http.get("http://localhost:8080/SpringRestfulWebServicesWithJSONExample/pessoas").then(
				function(result){
					var pessoas = result.data;

					promessa.resolve(pessoas);
				}
			);

			return promessa.promise;
		},
		
		listarCountry: function() {
			var promessa = $q.defer();

			$http.get("http://localhost:8080/SpringRestfulWebServicesWithJSONExample/countries").then(
				function(result){
					promessa.resolve(result.data);
				}
			);

			return promessa.promise;
		},
		inserir: function(pessoa) {			
			return $http.put("http://localhost:8080/SpringRestfulWebServicesWithJSONExample/addPerson/", pessoa);
		},
		remover: function(id) {
			return $http.delete("http://localhost:8080/SpringRestfulWebServicesWithJSONExample/deletePerson/" + id);
		}
	};
});
<%@page session="false"%>


<!DOCTYPE html>
<html lang="en">
<head>
<title>Spring MVC 4 + Ajax Hello World</title>

<meta name="viewreport" content="width=device-width, initial-scale=1.0">
<meta char="uft-8">

<c:url value="/resources/core/css/bootstrap.min.css"
	var="bootstrapCss" />
<c:url var="home" value="/" scope="request" />
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<link href="/SpringRestfulWebServicesWithJSONExample/resources/core/css/bootstrap.min.css" rel="stylesheet" />

<script src="/SpringRestfulWebServicesWithJSONExample/resources/core/js/jquery.1.10.2.min.js"></script>

</head>


<div class="container" >
	<div class="row">
		<div class="col-xs-12">
		<input type="button" value="Search"  onclick="search();">
		</div>
		<div class="col-xs-12">
		
	<div class="table-responsive" ng-app="myApp" ng-controller="customersCtrl" ng-init="header={name:'wilson', lastName:'Hisdatomi'}, teste='d'">
		<table id="products-table" class="table table-hover table-bordered table-striped table-condensed">
			<thead>
				<tr class="success">
					<th ><span ng-bind="header.name"></span></th>
					<th>{{teste}}</th>
					<th>Country</th>
					<th>Deletar</th>
				</tr>
			</thead>
			<tbody>
				  <tr ng-repeat="x in names | orderBy : 'country'">
				  <pessoa></pessoa>
				  </tr>
			</tbody>
		</table>
		</div>
		</div>
	</div>
</div>


<script>
var app = angular.module('myApp', []);
app.controller('customersCtrl', function($scope, $http) {
    $http.get("http://localhost:8080/SpringRestfulWebServicesWithJSONExample/pessoas")
    .then(function (response) {$scope.names = response.data;});
});
app.directive("pessoa", function() {
    return {
    	restrict: "E",
        templateUrl : "/SpringRestfulWebServicesWithJSONExample/pessoa.html"
      
    };
});
	jQuery(document).ready(function($) {
				
		
		

		$("#search-form").submit(function(event) {

			// Disble the search button
			enableSearchButton(false);

			// Prevent the form from submitting via the browser.
			event.preventDefault();

			//searchViaAjax();
			if ($("#id").val()==''){
				searchViaAjaxLista();
			} else {
				searchViaAjax();
			}

		});

	});
	
	function search() {
		$('#myTbody').remove();
		$.ajax(
				   {
				      type:'GET',
				      url:'http://localhost:8080/SpringRestfulWebServicesWithJSONExample/pessoas',
				      dataType : 'json',
						timeout : 100000,
				      success: function(data){
				    	addLinha(data);
				       
				      }
				   }
				);

	}
	
	function removeLinhas(id) {
		var tr = $("#linha"+id).closest('tr');

	    tr.fadeOut(400, function(){ 
	      tr.remove(); 
	    }); 
				
	}
	
	function addLinha(data) {
		var json = jQuery.parseJSON(JSON.stringify(data, null, 4) );
		
		var names = '';
		var table = $("<tbody id='myTbody'>");
		$.each(json, function(idx, obj) {
			
			var newRow = $("<tr id=linha"+obj.id+">");
		    var cols = "";

		    cols += '<th>'+obj.id+'</th>';
		    cols += '<th>'+obj.name+'</th>';
		    cols += '<th>'+obj.country+'</th>';		    
		    cols += '<th><input type=button value=Deletar onclick=deletar('+obj.id+');></th>';
		    newRow.append(cols);
		    
		    table.append(newRow);	
		});
		
	    $("#products-table").append(table);
		
		
			
			
	}
	

	function searchViaAjaxLista() {

		$.ajax(
				   {
				      type:'GET',
				      url:'http://localhost:8080/SpringRestfulWebServicesWithJSONExample/pessoas',
				      dataType : 'json',
						timeout : 100000,
				      success: function(data){
				    	addLinha(data);
				       
				      }
				   }
				);
	}
	
	function deletar(id) {
		removeLinhas(id);
	
		$.ajax(
				   {
				      type:'DELETE',
				      url:'http://localhost:8080/SpringRestfulWebServicesWithJSONExample/deletePerson/'+id,
				      data: JSON.stringify(search),
				      dataType : 'json',
						timeout : 100000,
				      success: function(data){
				    	display(data);
				       
				      }
				   }
				);
	}



	function searchViaAjax() {

		var search = {}
		search["id"] = $("#id").val();
		$.ajax(
				   {
				      type:'GET',
				      url:'http://localhost:8080/SpringRestfulWebServicesWithJSONExample/person/'+$("#id").val(),
				      data: JSON.stringify(search),
				      dataType : 'json',
						timeout : 100000,
				      success: function(data){
				    	display(data);
				       
				      }
				   }
				);
	}

	function enableSearchButton(flag) {
		$("#btn-search").prop("disabled", flag);
	}

	function displayLista(data) {
		
		var json = jQuery.parseJSON(JSON.stringify(data, null, 4) );
	
		var names = '';
		$.each(json, function(idx, obj) {
			names = names + "/" +obj.name ;
			
			
		});
		$('#feedback').html(names);
	}
	
	function display(data) {
		var obj = jQuery.parseJSON(JSON.stringify(data, null, 4) );
		$('#feedback').html(obj.name);
		
	}
	
	//var obj = jQuery.parseJSON( '{ "name": "John" }' );
	//alert( obj.name === "John" );
</script>

</body>
</html>
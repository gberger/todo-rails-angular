angular.module("todoApp")

.directive 'bsSort', ($location) ->
			templateUrl: 'partials/bs-sort.html'
			scope:
				attributes: '='
			link: (scope) ->
				scope.search = $location.search()['order']

				if scope.search
					[name, direction] = scope.search.split(' ')
					for attr in scope.attributes
						if attr.varName == name
							attr.direction = direction

				scope.click = (attr) ->
					for _attr in scope.attributes when _attr != attr
						_attr.direction = null
					if attr.direction == 'asc'
						attr.direction = 'desc'
						scope.search = attr.varName + ' ' + 'desc'
					else
						attr.direction = 'asc'
						scope.search = attr.varName + ' ' + 'asc'

				scope.$watch 'search', (search) ->
					$location.search('order', search)

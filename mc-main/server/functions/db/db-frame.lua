DB = {Async = {}, Sync = {}}
-- Async Functions --
DB.Async.Query = function(querystring, parameters, callback) -- Use this for INSERT, DELETE, and UPDATE.
    return exports['GHMattiMySQL']:QueryAsync( querystring, parameters, callback )
end

DB.Async.QueryResult = function(querystring, parameters, callback) -- Use this for SELECT statements. It returns the rows, with the selected elements inside as the parameter for your callback function. You have no idea what it contains? Just use print(json.encode(result)) to see the results.
    return exports['GHMattiMySQL']:QueryResultAsync( querystring, parameters, callback )
end

DB.Async.QueryScalar = function(querystring, parameters, callback) -- returns a singular value as parameter for your callback function only.
    return exports['GHMattiMySQL']:QueryScalarAsync( querystring, parameters, callback )
end

DB.Async.Transaction = function(querylist, parameters, callback) -- This function is used for transactions, which are essentially multiple linked INSERT / UPDATE / DELETE statements. If one fails the transaction will try and rollback all of them. If the rollback fails, the resource will crash intentionally. The callback gets return true or false depending on whether the transaction succeeded or failed.
    return exports['GHMattiMySQL']:TransactionAsync( querylist, parameters, callback )
end

DB.Async.Insert = function(tablename, rowsarray, callback) -- Use this function for multi-row inserts, it will write out a single command to do multiple inserts into tablename. The rows-array is constructed as illustrated by the following example: {{["id"]=1,["name"]="John"},{["id"]=2,["name"]="Peter"},{["id"]=3,["name"]="Paul"}}. The callback just returns the amount of rows inserted, if you put the optional boolean to true though, it will return the last insert id.
    return exports['GHMattiMySQL']:Insert( tablename, rowsarray, callback )
end

-- Sync Functions --
DB.Sync.Query = function(querystring, parameters, callback) -- Use this for INSERT, DELETE, and UPDATE. This currently awaits a result at the end, if you do not want that behaviour, use an Async export. If in doubt, use the Async export for this.
    return exports['GHMattiMySQL']:Query( querystring, parameters, callback )
end

DB.Sync.QueryResult = function(querystring, parameters, callback) -- Use this for SELECT statements. It returns the rows, with the selected elements inside. You have no idea what it contains? Just print(json.encode(result)) your results.
    return exports['GHMattiMySQL']:QueryResult( querystring, parameters, callback )
end

DB.Sync.QueryScalar = function(querystring, parameters, callback) -- returns a singular value only.
    return exports['GHMattiMySQL']:QueryScalar( querystring, parameters, callback )
end

DB.Sync.Transaction = function(querylist, parameters, callback) -- This function is used for transactions, which are essentially multiple linked INSERT / UPDATE / DELETE statements. If one fails the transaction will try and rollback all of them. If the rollback fails, the resource will crash intentionally. This export returns true or false depending on whether the transaction succeeded or failed.
    return exports['GHMattiMySQL']:Transaction( querylist, parameters, callback )
end

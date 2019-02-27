Select [definition], LEN([definition]) [definition_length], [uses_ansi_nulls], [uses_quoted_identifier], 
    [is_schema_bound], [uses_database_collation], [is_recompiled], 
    [null_on_null_input], [execute_as_principal_id], 
    [uses_native_compilation]
From [sys].[sql_modules]
Where [object_id] = @object_Id

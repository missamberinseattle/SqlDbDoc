Select [P].[name], TYPE_NAME([P].[system_type_id]) [type], 
	Case 
		When [P].[max_length] = -1 Then 'MAX'
		Else Convert(varchar, [max_length])
	End [max_length], 
	[P].[precision], [P].[scale], [P].[is_output], [P].[is_cursor_ref], 
	[P].[has_default_value], [P].[is_xml_document], [P].[default_value], 
	[P].[xml_collection_id], [P].[is_readonly], [P].[is_nullable], 
	[P].[encryption_type], [P].[encryption_type_desc], 
	[P].[encryption_algorithm_name], [P].[column_encryption_key_id], 
	[P].[column_encryption_key_database_name]
From [sys].[parameters] [P]
Where [P].[object_id] = @object_id
Order By [P].[parameter_id]
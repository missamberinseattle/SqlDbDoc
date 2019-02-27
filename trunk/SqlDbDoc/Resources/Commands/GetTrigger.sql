Select [T].[name], [T].[object_id], [T].[parent_class], [T].[parent_class_desc], [T].[parent_id], [T].[type], [T].[type_desc], [T].[create_date], [T].[modify_date], [T].[is_ms_shipped], [T].[is_disabled], [T].[is_not_for_replication], [T].[is_instead_of_trigger]
From [sys].[triggers] [T]
Where [T].[object_id] = @object_id

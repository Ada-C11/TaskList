ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::
  NATIVE_DATABASE_TYPES[:datetime] = {name: "timestamp with time zone"} 

  #  Rails doesn’t support time with time zone, code above added so it should work. =)
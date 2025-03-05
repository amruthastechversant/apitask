<cfcomponent rest="true" restpath="hello">

    <cffunction name="sayHello" access="remote" returnType="String" httpMethod="GET" restPath="sayHello">

        <cfset res="Hello World">

        <cfreturn res>

    </cffunction>

    <cffunction name="sayHello2" access="remote" returnType="String" httpMethod="GET" restPath="sayHello2">

        <cfset res="Hello World 2">

        <cfreturn res>

    </cffunction>

    <cffunction  name="addDetails" access="remote" returnType="string" httpMethod="POST" restPath="addDetails">
        <cfargument name="title" type="string" restArgSource="form">
        <cfargument  name="description" type="string" restArgSource="form">
    
        <cfset var message="added successfully">

        <cftry>
        <cfquery datasource="dsn_addressbook">
            insert into testapi(title,description)
            values(
                <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.description#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
            <cfcatch>
                    <cfset message="error:#cfcatch.message#">
            </cfcatch>
        </cftry>
            <cfreturn message>

    </cffunction>

    <cffunction  name="getDetails" access="remote" returnType="any" httpMethod="GET" restPath="getDetails">
        <cfquery name="getData"  datasource="dsn_addressbook">
            select id,title,description from testapi order by id DESC
        </cfquery>
        <cfreturn getData>
    </cffunction>

   <cffunction  name="updateDetails" access="remote" returnType="any" httpMethod="PUT" restPath="updateDetails">   
        <cfargument name="testid" type="numeric" restArgSource="form">
        <cfargument name="title" type="string" restArgSource="form">
        <cfargument name="description" type="string" restArgSource="form">

       <cfquery name="updateData" datasource="dsn_addressbook">
            UPDATE testapi
           set title=<cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
            description=<cfqueryparam value="#arguments.description#" cfsqltype="cf_sql_varchar">
            where id=<cfqueryparam value="#arguments.testid#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn 1>
    </cffunction>

<cffunction name="DeleteDetails" access="remote" returnType="any" httpMethod="delete" restPath="DeleteDetails/{deleteid}">
    <cfargument name="deleteid" type="numeric" restArgSource="path">
    <cfquery name="deletedata">
        DELETE FROM testapi
        WHERE id = <cfqueryparam value="#arguments.deleteid#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn 1>
</cffunction>

 


    <cffunction  name="getitemdetails" access="remote" returnType="any" httpMethod="GET" restPath="getitemdetails" produces="text/plain">
        <cfargument  name="id" type="numeric" required="true" restArgSource="header">
        <cfquery name="getData"  datasource="dsn_addressbook">
            select title,description from testapi 
           where id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn getData>
    </cffunction>
</cfcomponent>
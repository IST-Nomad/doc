DECLARE
 KEYNUM NUMBER;
BEGIN
  SYS.DBMS_JAVA.GRANT_PERMISSION(
     grantee           => 'KRONA'
    ,permission_type   => 'SYS:java.lang.reflect.ReflectPermission'
    ,permission_name   => 'suppressAccessChecks'
    ,permission_action => ''
    ,key               => KEYNUM
    );
END;
/
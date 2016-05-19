
  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "LOGUSER"."JIRA_REST_WS_PKG" IS

  FUNCTION get_issue(in_jira_base_url  IN VARCHAR2,
                     in_jira_issue_id  IN NUMBER,
                     in_jira_issue_key IN VARCHAR2) RETURN t_jira_issue IS
    l_clob       CLOB;
    l_values     apex_json.t_values;
    l_jira_issue t_jira_issue;
  BEGIN
    -- Test statements here
    l_clob := apex_web_service.make_rest_request( --p_url         => 'https://gost-jira.atlassian.net/rest/api/2/search?jql=assignee=alexey.sluchko',
                                                 p_url         => 'https://gost-jira.atlassian.net/rest/api/2/issue/UFAP-486',
                                                 p_http_method => 'GET',
                                                 p_wallet_path => 'file:/u01/app/oracle/wallet',
                                                 p_wallet_pwd  => 'WalletPasswd123',
                                                 p_username    => 'alexey.sluchko',
                                                 p_password    => 'lokiftwww011187');
  
    apex_json.parse(p_values => l_values, p_source => l_clob);
  
    t_jira_issue.id        := apex_json.get_varchar2(p_values => l_values, p_path => 'id');
    t_jira_issue.url_json  := apex_json.get_varchar2(p_values => l_values, p_path => 'self');
    t_jira_issue.key       := apex_json.get_varchar2(p_values => l_values, p_path => 'key');
    t_jira_issue.timespent := apex_json.get_number(p_values => l_values, p_path => 'fields.timespent');
  
    RETURN l_jira_issue;
  
  END;

END jira_rest_ws_pkg;

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "LOGUSER"."JIRA_REST_WS_PKG" IS

  FUNCTION get_issue(in_jira_issue_id  IN NUMBER,
                     in_jira_issue_key IN VARCHAR2) RETURN t_jira_issue IS
    l_clob       CLOB;
    l_values     apex_json.t_values;
    l_jira_issue t_jira_issue;
  BEGIN
    -- Test statements here
    l_clob := apex_web_service.make_rest_request(p_url         => get_env('jira_api_location') ||
                                                                  get_env('jira_api_location_issue') || '/' ||
                                                                  nvl(to_char(in_jira_issue_id), in_jira_issue_key),
                                                 p_http_method => 'GET',
                                                 p_wallet_path => get_env('wallet_location'),
                                                 p_wallet_pwd  => get_env('wallet_password'),
                                                 p_username    => get_env('jira_delault_user'),
                                                 p_password    => get_env('jira_delault_password'));
  
    apex_json.parse(p_values => l_values, p_source => l_clob);
  
    l_jira_issue := t_jira_issue(id        => apex_json.get_varchar2(p_values => l_values, p_path => 'id'),
                                 url_json  => apex_json.get_varchar2(p_values => l_values, p_path => 'self'),
                                 key       => apex_json.get_varchar2(p_values => l_values, p_path => 'key'),
                                 timespent => apex_json.get_number(p_values => l_values, p_path => 'fields.timespent'));
  
    RETURN l_jira_issue;
  
  END;

  FUNCTION get_issue_search_assignee(in_jira_issue_id  IN NUMBER,
                                     in_jira_issue_key IN VARCHAR2) RETURN t_jira_issue IS
    l_clob       CLOB;
    l_values     apex_json.t_values;
    l_jira_issue t_jira_issue;
  BEGIN

    l_clob := apex_web_service.make_rest_request(p_url         => get_env('jira_api_location') ||
                                                                  get_env('jira_api_location_search_assignee') ||
                                                                  get_env('jira_delault_user'),
                                                 p_http_method => 'GET',
                                                 p_wallet_path => get_env('wallet_location'),
                                                 p_wallet_pwd  => get_env('wallet_password'),
                                                 p_username    => get_env('jira_delault_user'),
                                                 p_password    => get_env('jira_delault_password'));
  
    apex_json.parse(p_values => l_values, p_source => l_clob);
  
    l_jira_issue := t_jira_issue(id        => apex_json.get_varchar2(p_values => l_values, p_path => 'id'),
                                 url_json  => apex_json.get_varchar2(p_values => l_values, p_path => 'self'),
                                 key       => apex_json.get_varchar2(p_values => l_values, p_path => 'key'),
                                 timespent => apex_json.get_number(p_values => l_values, p_path => 'fields.timespent'));
  
    RETURN l_jira_issue;
  
  END;

END jira_rest_ws_pkg;

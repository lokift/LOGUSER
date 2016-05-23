
  CREATE OR REPLACE EDITIONABLE PACKAGE "LOGUSER"."JIRA_REST_WS_PKG" IS

  -- Author  : ASLUCHKO
  -- Created : 19.05.2016 13:08:16
  -- Purpose : 

  FUNCTION get_issue(in_jira_issue_id  IN NUMBER,
                     in_jira_issue_key IN VARCHAR2) RETURN t_jira_issue;

END jira_rest_ws_pkg;

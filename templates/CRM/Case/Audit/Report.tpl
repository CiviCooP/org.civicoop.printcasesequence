{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.3                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2013                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
 | Extension org.civicoop.printcasesequence                           |
 | Author       :   Erik Hommel (erik.hommel@civicoop.org)            |
 | Date         :   24 Oct 2014                                       |
 | Description  :   Change sequence of print case to activity_date
 |                                                                    |
 +--------------------------------------------------------------------+
*}
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$config->lcMessages|truncate:2:"":true}" xml:lang="{$config->lcMessages|truncate:2:"":true}">
<head>
  <title>{$pageTitle}</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <base href="{crmURL p="" a=true}" /><!--[if IE]></base><![endif]-->
  <style type="text/css" media="screen, print">@import url({$config->userFrameworkResourceURL}css/print.css);</style>
</head>

<body>
  <div id="crm-container" class="crm-container">
    <h1>{$pageTitle}</h1>
    <div id="report-date">{$reportDate}</div>
    <h2>{ts}Case Summary{/ts}</h2>
    <table class="report-layout">
      <tr>
        <th class="reports-header">{ts}Client{/ts}</th>
        <th class="reports-header">{ts}Case Type{/ts}</th>
        <th class="reports-header">{ts}Status{/ts}</th>
        <th class="reports-header">{ts}Start Date{/ts}</th>
        <th class="reports-header">{ts}Case ID{/ts}</th>
      </tr>
      <tr>
        <td class="crm-case-report-clientName">{$case.clientName}</td>
        <td class="crm-case-report-caseType">{$case.caseType}</td>
        <td class="crm-case-report-status">{$case.status}</td>
        <td class="crm-case-report-start_date">{$case.start_date}</td>
        <td class="crm-case-report-{$caseId}">{$caseId}</td>
      </tr>       
    </table>
    <h2>{ts}Case Roles{/ts}</h2>
    <table class ="report-layout">
      <tr>
        <th class="reports-header">{ts}Case Role{/ts}</th>
        <th class="reports-header">{ts}Name{/ts}</th>
        <th class="reports-header">{ts}Phone{/ts}</th>
        <th class="reports-header">{ts}Email{/ts}</th>
      </tr>

      {foreach from=$caseRelationships item=row key=relId}
        <tr>
          <td class="crm-case-report-caserelationships-relation">{$row.relation}</td>
          <td class="crm-case-report-caserelationships-name">{$row.name}</td>
          <td class="crm-case-report-caserelationships-phone">{$row.phone}</td>
          <td class="crm-case-report-caserelationships-email">{$row.email}</td>
        </tr>
      {/foreach}
      {foreach from=$caseRoles item=relName key=relTypeID}
        {if $relTypeID neq 'client'}
          <tr>
            <td>{$relName}</td>
            <td>{ts}(not assigned){/ts}</td>
            <td></td>
            <td></td>
          </tr>
        {else}
          <tr>
            <td class="crm-case-report-caseroles-role">{$relName.role}</td>
            <td class="crm-case-report-caseroles-sort_name">{$relName.sort_name}</td>
            <td class="crm-case-report-caseroles-phone">{$relName.phone}</td>
            <td class="crm-case-report-caseroles-email">{$relName.email}</td>
          </tr>
        {/if}
      {/foreach}
    </table>
    <br />

    {if $otherRelationships}
      <table  class ="report-layout">
        <tr>
          <th class="reports-header">{ts}Client Relationship{/ts}</th>
          <th class="reports-header">{ts}Name{/ts}</th>
          <th class="reports-header">{ts}Phone{/ts}</th>
          <th class="reports-header">{ts}Email{/ts}</th>
        </tr>
        {foreach from=$otherRelationships item=row key=relId}
          <tr>
            <td class="crm-case-report-otherrelationships-relation">{$row.relation}</td>
            <td class="crm-case-report-otherrelationships-name">{$row.name}</td>
            <td class="crm-case-report-otherrelationships-phone">{$row.phone}</td>
            <td class="crm-case-report-otherrelationships-email">{$row.email}</td>
          </tr>
        {/foreach}
      </table>
      <br />
    {/if}

    {if $globalRelationships}
      <table class ="report-layout">
        <tr>
          <th class="reports-header">{$globalGroupInfo.title}</th>
          <th class="reports-header">{ts}Phone{/ts}</th>
          <th class="reports-header">{ts}Email{/ts}</th>
        </tr>
        {foreach from=$globalRelationships item=row key=relId}
          <tr>
            <td class="crm-case-report-globalrelationships-sort_name">{$row.sort_name}</td>
            <td class="crm-case-report-globalrelationships-phone">{$row.phone}</td>
            <td class="crm-case-report-globalrelationships-email">{$row.email}</td>
          </tr>
        {/foreach}
      </table>
    {/if}

    <h2>{ts}Case Activities{/ts}</h2>
    {crmAPI var='caseActivities' entity='CaseActivity' action='get' q='civicrm/ajax/rest' sequential=1 case_id=$caseId}
    {foreach from=$caseActivities.values item=caseActivity} 
      <table class="report-layout">
        <tr class="crm-case-report-activity-status">
          <th scope="row" class="label">{ts}Status{/ts}</th>
          <td>{$caseActivity.status|escape}</td>
        </tr>
        <tr class="crm-case-report-activity-client">
          <th scope="row" class="label">{ts}Client{/ts}</th>
          <td>
            {assign var='targetFirst' value='1'}
            {foreach from=$caseActivity.targets item=target}
              {if $targetFirst eq '1'}
                {assign var='targetFirst' value='0'}
              {else}
                &comma;&nbsp;
              {/if}                    
              {$target.target_contact_name|escape}
            {/foreach}
          </td>
        </tr>
        <tr class="crm-case-report-activity-type">
          <th scope="row" class="label">{ts}Activity Type{/ts}</th>
          <td>{$caseActivity.activity_type|escape}</td>
        </tr>
        <tr class="crm-case-report-activity-subject">
          <th scope="row" class="label">{ts}Subject{/ts}</th>
          <td class="bold">{$caseActivity.subject}</td>
        </tr>
        <tr class="crm-case-report-activity-source-name">
          <th scope="row" class="label">{ts}Created by{/ts}</th>
          <td>{$caseActivity.source_name|escape}</td>
        </tr>
        <tr class="crm-case-report-activity-medium">
          <th scope="row" class="label">{ts}Medium{/ts}</th>
          <td>{$caseActivity.medium|escape}</td>
        </tr>
        <tr class="crm-case-report-activity-location">
          <th scope="row" class="label">{ts}Location{/ts}</th>
          <td>{$caseActivity.location|escape}</td>
        </tr>
        <tr class="crm-case-report-activity-activity_date_time">
          <th scope="row" class="label">{ts}Date{/ts}&sol;{ts}Time{/ts}</th>
          <td>{$caseActivity.activity_date_time|date_format:"%e %B %Y %R"}</td>
        </tr>
        <tr class="crm-case-report-activity-details">
          <th scope="row" class="label">{ts}Details{/ts}</th>
          <td>
            {* If using plain textarea, assign class=huge to make input large enough. *}
            {$caseActivity.details}
          </td>
        </tr>
        <tr class="crm-case-report-activity-priority">
          <th scope="row" class="label">{ts}Priority{/ts}</th>
          <td>{$caseActivity.priority}</td>
        </tr>
        <tr class="crm-case-report-activity-assignee">
          <th scope="row" class="label">{ts}Assigned to{/ts}</th>
          <td>
            {assign var='assigneeFirst' value='1'}
            {foreach from=$caseActivity.assignees item=assignee}
              {if $assigneeFirst eq '1'}
                {assign var='assigneeFirst' value='0'}
              {else}
                &comma;&nbsp;
              {/if}                    
              {$assignee.assignee_contact_name|escape}
            {/foreach}
          </td>
        </tr>
      </table>
      <br />
    {/foreach}
  </div>
</body>
</html>






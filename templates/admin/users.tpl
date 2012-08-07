﻿<!-- users.tpl -->
{literal}
<script type="text/javascript" language="javascript">

function submit_list_form(){
		document.getElementById("user_list_form").submit();
		//for(x in document.getElementById("user_list_form"))
		//alert(x);
		//alert(document.getElementById("user_list_form"));
}
</script>
{/literal}
<legend>{#PLIGG_Visual_AdminPanel_User_Manage#}</legend>
{include file="/admin/user_create.tpl"}
<table>
	<tr>
		<form action="{$my_base_url}{$my_pligg_base}/admin/admin_users.php" method="get">
			<td>
				<div class="input-append">
					<input type="hidden" name="mode" value="search">
					{if isset($templatelite.get.keyword) && $templatelite.get.keyword neq ""}
							{assign var=searchboxtext value=$templatelite.get.keyword|sanitize:2}
					{else}
							{assign var=searchboxtext value=#PLIGG_Visual_Search_SearchDefaultText#}			
					{/if}
					<input type="text" size="30" class="span7" name="keyword" value="{$searchboxtext}" onfocus="if(this.value == '{$searchboxtext}') {ldelim}this.value = '';{rdelim}" onblur="if (this.value == '') {ldelim}this.value = '{$searchboxtext}';{rdelim}"><button type="submit" class="btn">{#PLIGG_Visual_Search_Go#}</button>
				</div>
			</td>
			<td>
				<select name="filter" style="margin-right:10px;"onchange="this.form.submit()">
					<option value="">-- User Level --</option>
					<option value="admin" {if $templatelite.get.filter == "admin"} selected="selected" {/if}>Admin</option>
					<option value="moderator" {if $templatelite.get.filter == "moderator"} selected="selected" {/if}>Moderator</option>
					<option value="normal" {if $templatelite.get.filter == "normal"} selected="selected" {/if}>Normal</option>
					<option value="spammer" {if $templatelite.get.filter == "spammer"} selected="selected" {/if}>Spammer</option>
				</select>
			</td>
			<td>
				<select name="pagesize" onchange="this.form.submit()">
					<option value="15" {if isset($pagesize) && $pagesize == 15}selected{/if}>Show 15</option>
					<option value="30" {if isset($pagesize) && $pagesize == 30}selected{/if}>Show 30</option>
					<option value="50" {if isset($pagesize) && $pagesize == 50}selected{/if}>Show 50</option>
					<option value="100" {if isset($pagesize) && $pagesize == 100}selected{/if}>Show 100</option>
					<option value="200" {if isset($pagesize) && $pagesize == 200}selected{/if}>Show 200</option>
				</select>
			</td>
		</form>
        
             	
			<td style="float:right;">
           
           
            <input type="button" class="btn btn-primary" name="btnsubmit" value="{#PLIGG_Visual_AdminPanel_Apply_Changes#}" onclick="submit_list_form()" />
            
            </td>
	</tr>
</table>
{if isset($usererror)}
	<span class="error">{$usererror}</span><br/>
{/if}
<form name="user_list_formasd" id="user_list_form" action="{$my_base_url}{$my_pligg_base}/admin/admin_users.php" method="post">
<input type="hidden" name="frmsubmit" value="userlist" />	
{$hidden_token_admin_users_list}
<table class="table table-bordered table-condensed tablesorter" id="tablesorter-userTable">
	<thead>
		<tr>
			<th style="width:40px;text-align:center;">ID</th>
			<th>{#PLIGG_Visual_Login_Username#}</th>
			<th style="text-align:center;">{#PLIGG_Visual_View_User_Level#}</th>
			<th>{#PLIGG_Visual_View_User_Email#}</th>
			<th style="width:140px">{#PLIGG_Visual_User_Profile_Joined#}</th>
			<th style="text-align:center;">{#PLIGG_Visual_User_Profile_Enabled#}</th>
			<th style="text-align:center;">{#PLIGG_Visual_KillSpam#}</th>
		</tr>
	</thead>
	<tbody>
		{section name=nr loop=$userlist}
			<tr {if $userlist[nr].user_enabled eq '0'}class="tr_moderated"{/if}>
				<td style="width:40px;text-align:center;vertical-align:middle;">{$userlist[nr].user_id}</td>
				<td style="vertical-align:middle;"><img src="{$userlist[nr].Avatar}" style="height:18px;width:18px;" /> <a href = "?mode=view&user={$userlist[nr].user_login}">{$userlist[nr].user_login}</a></td>	
				<td style="text-align:center;vertical-align:middle;">{$userlist[nr].user_level}</td>
				<td style="vertical-align:middle;">
					{if $userlist[nr].user_lastlogin neq "0000-00-00 00:00:00"}
						<i class="icon icon-ok" title="{#PLIGG_Visual_AdminPanel_Confirmed_Email#}" alt="{#PLIGG_Visual_AdminPanel_Confirmed_Email#}"></i>
					{else}
						<a data-toggle="modal" href="{$my_base_url}{$my_pligg_base}/admin/admin_user_validate.php?id={$userlist[nr].user_id}" title="{#PLIGG_Visual_AdminPanel_Confirmed_Email#}"><i class="icon icon-warning-sign" title="{#PLIGG_Visual_AdminPanel_Unconfirmed_Email#}"></i></a>
					{/if}
					<a href="mailto:{$userlist[nr].user_email}" target="_blank">{$userlist[nr].user_email|truncate:25:"...":true}</a>
				</td>
				<td>{$userlist[nr].user_date}</td>
				<td style="text-align:center;vertical-align:middle;">
					<input type="radio" name="enabled[{$userlist[nr].user_id}]"  {if $userlist[nr].user_enabled}checked{/if} value="1">
					<!--<input type="hidden" name="enabled[{$userlist[nr].user_id}]" id="enabled_{$userlist[nr].user_id}" value="{$userlist[nr].user_enabled}">-->
				</td>
				<td style="text-align:center;vertical-align:middle;"><div style="text-align:center"><input type="radio" id='killspam' name='enabled[{$userlist[nr].user_id}]' value='0' {if $userlist[nr].user_enabled neq 1}checked{/if}></div></td>	
			</tr>
		{/section}
	</tbody>
</table>
</form>
<div style="float:right;margin:8px 2px 0 0;">
<a class="btn btn-success"  href="#createUserForm-modal" data-toggle="modal" title="{#PLIGG_Visual_AdminPanel_New_User#}">{#PLIGG_Visual_AdminPanel_New_User#}</a>
	<input type="button" class="btn btn-primary" name="btnsubmit" value="{#PLIGG_Visual_AdminPanel_Apply_Changes#}" onclick="submit_list_form()" />
</div>


<div style="clear:both;"></div>

<SCRIPT>
{literal}
function check_all(elem) {
	for (var i=0; i< document.bulk.length; i++) 
		if (document.bulk[i].id == "killspam")
			document.bulk[i].checked = elem.checked;
}
{/literal}
</SCRIPT>
<!--/users.tpl -->
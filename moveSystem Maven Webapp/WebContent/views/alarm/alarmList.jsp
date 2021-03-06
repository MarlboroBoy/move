<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/common/views/common.jsp"%>
    <!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>H+ 后台主题UI框架 - Bootstrap Table</title>
    <meta name="keywords" content="H+后台主题,后台bootstrap框架,会员中心主题,后台HTML,响应式后台">
    <meta name="description" content="H+是一个完全响应式，基于Bootstrap3最新版本开发的扁平化主题，她采用了主流的左右两栏式布局，使用了Html5+CSS3等现代技术">

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="../css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="../css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="../css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css?v=4.1.0" rel="stylesheet">
     <link rel="stylesheet" href="../bootstrap3-dialog-master/dist/css/bootstrap-dialog.css"/>

</head>
    <script type="text/javascript">
    $(function(){
    	
    	 $('#exampleTableEvents').bootstrapTable({
             url: "${ctx}/alarmRecord/queryAlarmRecordList.do",
             search: true,
             pagination: true,
             showRefresh: true,
             showToggle: true,
             showColumns: true,
             iconSize: 'outline',
             toolbar: '#exampleTableEventsToolbar',
             checkbox:true,
             clickToSelect:true,
             onClickRow:function(row, $element){
             	
             }
           ,
             icons: {
               refresh: 'glyphicon-repeat',
               toggle: 'glyphicon-list-alt',
               columns: 'glyphicon-list'
             }
           })
    	
    })
    
    
  
    
    </script>
    
    
    
    <script type="text/javascript">
    	function display() {
	addDetailInfo('http://localhost:8080/moveSystem/test/test1.do', '123', '1000px', '1000px');
	//      BootstrapDialog.show({
	//      	type: BootstrapDialog.TYPE_PRIMARY,
	//      size: BootstrapDialog.SIZE_WIDE,
	//      nl2br: true,
	//          title: '详情',
	//          message: this.parent.load(''),
	//          closable:true         
	//      });
}</script>

<script>
function addDetailInfo(url, title, formId, cssClasses) {
	var $that = $(this);
	var formUrl = url;
	if(url.indexOf("?") != -1) {
		formUrl = url.substring(0, url.indexOf("?")) + "/form";
	} else {
		formUrl = url + "/form";
	}
	//失效  
	$that.attr("disabled", "disabled");
	// 调用add方法  
	var dialog = BootstrapDialog.show({
		type: BootstrapDialog.TYPE_DEFAULT,
		title:  title,
		closable: false,
		draggable: true,
		cssClass: cssClasses,
		message: $('<div></div>').load(url), //加载弹出页面  
		size: BootstrapDialog.SIZE_WIDE, //弹出框大小。  
		onhide: function() {
			$that.removeAttr("disabled");
		},
		buttons: [{
			id: 'btn-form-submit',
			label: '提交',
			icon: 'fa fa-check-circle',
			cssClass: 'btn-primary',
			action: function(dialogRef) {
				var $button = this;
				//表单验证并提交  
				$('#' + formId).unbind("valid.form");
				$('#' + formId).bind('valid.form', function(e, form) {
					// Before submitting the form, hold form, to prevent duplicate submission.  
					//$(form).holdSubmit();  
					$button.disable();
					$.ajax({
						type: 'post',
						url: formUrl,
						data: $("#" + formId).serialize(), //序列化表格内容为字符串    
						cache: false,
						dataType: 'json',
						success: function(data) {
							// After the form is submitted successfully, release hold.  
							//$(form).holdSubmit(false);  
							$button.enable();
							BootstrapDialog.alertSuccess("提交成功!", function() {
								//当前页面刷新  
								window.location.reload();
							});
							dialog.close();
						},
						error: function(error) {
							$button.enable();
							BootstrapDialog.alertError("提交失败!");
						}
					});
				});
				//提交表单  
				$('#' + formId).trigger("submit");
			}
		}, {
			label: '关闭',
			icon: 'fa fa-close',
			action: function(dialogItself) {
				dialogItself.close();
			}
		}]
	});
};</script>






<body class="gray-bg">
   
          
                    <div class="col-sm-12">
                        <!-- Example Events -->
                        <div class="example-wrap">
                 
                            <div class="example">
  
                                <div class="btn-group hidden-xs" id="exampleTableEventsToolbar" role="group">
                                    <button type="button" class="btn btn-outline btn-default">
                                        <i class="glyphicon glyphicon-plus" aria-hidden="true"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline btn-default" onclick="display()">
                                        <i class="glyphicon glyphicon-search" aria-hidden="true"></i>
                                        <small >查看</small>
                                    </button>
                                    <button type="button" class="btn btn-outline btn-default">
                                        <i class="glyphicon glyphicon-trash" aria-hidden="true"></i>
                                         <small >删除</small>
                                    </button>
                                </div>
                                <table id="exampleTableEvents" data-height="400" data-mobile-responsive="true">
                                    <thead>
                                        <tr>
                                            <th data-field="state" data-checkbox="true"></th>
                                            <th data-field="id">编号</th>
                                            <th data-field="licensePlate">车牌号</th>
                                            <th data-field="alarmAdress">违停车辆地址</th>
                                            <th data-field="carOwnName">车主姓名</th>
                                            <th data-field="telphone">车主电话</th>
                                            <th data-field="alarmid">报警人编号</th>
                                            <th data-field="userName">报警人用户名</th>     
                                            <th data-field="tel">报警人电话</th>
                                            <th data-field="processingState">处理状态</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <!-- End Example Events -->
                    </div>
   
    <!-- Peity 
    <script src="../js/admin/bootstrap-table-demo.js"></script>
-->

</body>

</html>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/3
  Time: 1:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<script type="text/html" id="barDemo">
    <a title="修改 "   onclick="updateQuestion()" href="javascript:;">
        <i class="layui-icon">&#xe642;</i>
    </a>
    <a title="删除"  onclick="deleteQuestion()" href="javascript:;" lay-event="edit">
        <i class="layui-icon">&#xe640;</i>
    </a>
</script>


<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div  style="margin-left: 20px">
    <div class="demoTable" >
        <button class="layui-btn layui-btn-danger" onclick="addQuestion()">增加题目</button>
    </div>
    <table id="questionInfo" lay-filter="questionInfo"></table>
</div>
</body>
<script>
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form = layui.form;
        var tableIns = table.render({
            elem: '#questionInfo'  //绑定table表格
            ,id:'questionInfo'
            ,method:'post'
            ,url: '${pageContext.request.contextPath}/findAllQuestionsByPage' //后台springmvc接收路径
            ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                ,groups: 1 //只显示 1 个连续页码
                ,first: false //不显示首页
                ,last: false //不显示尾页
                ,limit:3
                ,limits:[3,6,9]
            }
            ,cols: [
                [
                    {type: 'checkbox'}
                    ,{field:'id',title:'id', sort: true}
                    ,{field:'content', title:'问题内容'}
                    ,{field:'operation',title:'操作',toolbar: '#barDemo'}
                ]
            ]
        });
    });

    function addQuestion(){
        layer.open(
            {
                type: 2,
                title: '添加问题',
                skin: 'layui-layer-lan',
                shadeClose: false,
                shade: 0.8,
                area:  ['800px', '500px'],
                resize:true,
                content:'${pageContext.request.contextPath}/question_add',
                end: function(){
                    window.location.reload(); //刷新父页面
                }
            }
        );
    }
    function deleteQuestion() {
        var id="";
        layui.use('table',function(){
            var table = layui.table
            var checkStatus = table.checkStatus('questionInfo');
            id = checkStatus.data[0].id;
            $.ajax({
                url:'${pageContext.request.contextPath}/deleteQuestionById',
                data:{"id":id},
                type:'POST',
                success:function (data) {
                    console.log(data)
                    layer.msg("删除成功！",function(){

                    });
                },error:function(args){
                    layer.msg("删除失败！",function(){

                    });
                }
            })
        });
    }
    
    function updateQuestion() {
        var id="";
        layui.use('table',function(){
            var table = layui.table
            var checkStatus = table.checkStatus('questionInfo');
            id = checkStatus.data[0].id;
        });
        layer.open({
            type: 2,
            title: '修改问题内容',
            skin: 'layui-layer-molv',
            shadeClose: false,
            shade: 0.8,
            area:  ['700px', '450px'],
            content: 'question_update?id='+id,
            end: function(){
                window.location.reload(); //刷新父页面
            }
        });
    }
</script>
</html>

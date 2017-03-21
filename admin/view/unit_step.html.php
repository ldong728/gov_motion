<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span>单位流程权限控制</span></div>
        <div class="main">
            <table class="table sheet unit-table">
                <tr class="h">
                    <td rowspan="2">单位名称</td>
                    <td colspan="6">流程权限</td>
                    <td rowspan="2">类别</td>
                </tr>
                <tr>
                    <td>提交</td>
                    <td>登记</td>
                    <td>审核</td>
                    <td>交办</td>
                    <td>办理</td>
                    <td>反馈</td>
                </tr>
                <tr class="list-row">
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                </tr>
                <tr class="unit-table-foot">

                </tr>
            </table>
        </div>
    </div>
    <script>
        var page=0;
        var orderby='unit_id';
        var order=true;
        $(document).ready(function(){

            getUnitList();

        });
        function getUnitList(where){
            var orderStr=order?'asc':'desc';
            var whereValue=where||null;
            ajaxPost('reflashUnitList',{orderby:orderby,order:orderStr,page:page,where:whereValue},function(data){
               var list=backHandle(data);
                $('.list-row').remove();
                $.each(list,function(k,v){
                    var content='<tr class="list-row">'+
                        '<td>'+ v.unit_name+'</td>'+
                        '<td>abc</td>'+
                        '<td>abc</td>'+
                        '<td>abc</td>'+
                        '<td>abc</td>'+
                        '<td>abc</td>'+
                        '<td>abc</td>'+
                        '<td>abc</td>'+
                        '</tr>';
                    $('.unit-table-foot').before(content);

                });

            });
        }
    </script>
</div>
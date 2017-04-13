 <div class="mask"></div>
<div class="suggest flow cont">
    <div class="flow-head clearfix">
        <div class="flow-head-l"><h1>流程信息显示</h1></div>
        <div class="x"></div>
    </div>
    <div class="flow-main-content">
        <div class="table-flow">
            <div class="flow-icon "></div>
            <table width="715" border="1" bordercolor="#ff8712" cellspacing="0" cellpadding="0">
                <tbody>
                <tr >
                    <td><p><img src="stylesheet/images/flow-1.png"></p><p>环节名称</p></td>
                    <td><p><img src="stylesheet/images/flow-2.png"></p><p>环节处理人员</p></td>
                    <td><p><img src="stylesheet/images/flow-3.png"></p><p>环节传阅人员</p></td>
                    <td><p><img src="stylesheet/images/flow-4.png"></p><p>处理时间</p></td>
                </tr>
                <?php foreach($motionStepInf as $row):?>
                <tr>
                    <th><?php echo $row['step_name']?></th>
                    <td><?php echo $row['staff_name']?></td>
                    <td>无</td>
                    <td><?php echo $row['update_time']?></td>
                </tr>
                <?php endforeach?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    $('.x').click(function(){
            closePopUp($('.m-popup'));
            $('.mask').css('display', 'none');
//        window.location.reload(true);
//		$('.mask').css('display','none');
    })
</script>
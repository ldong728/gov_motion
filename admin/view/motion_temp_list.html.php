<?php global $list?>
<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span>模板列表</span></div>
        <div class="main">
            <table class="table sheet">
                <tr class="h">
                   <td>名称</td>
                    <td>操作</td>
                </tr>
                <?php foreach($list as $row):?>
                    <tr id="<?php echo $row['motion_template_id']?>">
                        <td class="ipt-toggle" id="<?php echo $row['motion_template_id'] ?>" data-col="motion_template_name" data-tbl="motion_template" data-index="<?php echo $row['motion_template_id'] ?>"><?php echo $row['motion_template_name']?></td>
                        <td><button class="button edit-button" id="edt<?php echo $row['motion_template_id']?>">编辑</button></td>
                    </tr>
                <?php endforeach?>
                <tr>
                    <td style="text-align: right">模板名称:</td>
                    <td>
                        <input type="text" id="temp-name" placeholder="填写模板名称">
                        <button class="button add-button">创建模板</button></td>
                </tr>
            </table>
        </div>
    </div>
</div>
<script>
    $('.add-button').click(function(){
        var name=$('#temp-name').val()||null;
        if(name){
            addRecord('motion_template',{motion_template_name:name},'update',function(){
                window.location.reload(true);
            })
        }
    });
    $('.edit-button').click(function(){
       var id=$(this).attr('id').slice(3);
        window.location.href="?menu=<?php echo $_GET['menu']?>&sub=motion_temp_edit&id="+id;
    });
</script>
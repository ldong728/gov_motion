<table>
    <?php foreach($handler as $row):?>
        <tr>
            <td><?php echo $row['name']?></td>
            <td data-col="<?php echo $row['col']?>"></td>

        </tr>

    <?php endforeach ?>

</table>

<button class="handler-motion">办理</button>

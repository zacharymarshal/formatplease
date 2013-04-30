<!DOCTYPE html>
<html>
<head>
<title>Format Please</title>
<link href="<?php echo url_for('media/font-awesome/css/font-awesome.min.css') ?>" rel="stylesheet">
<link href="<?php echo url_for('media/formatplease/css/main.css') ?>" rel="stylesheet">
</head>
<body>
<?php echo $content ?>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">var baseUrl = function(p) { return '<?php echo url_for('/') ?>' + p; }</script>
<script src="<?php echo url_for('media/formatplease/js/main.js') ?>"></script>
</body>
</html>
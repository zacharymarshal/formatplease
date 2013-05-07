<!DOCTYPE html>
<html>
<head>
<title>Format Please</title>
<link href="<?php echo url_for('media/font-awesome/css/font-awesome.min.css') ?>" rel="stylesheet">
<link href="<?php echo url_for('media/formatplease/css/main.css') ?>" rel="stylesheet">
</head>
<body>
<?php echo $content ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">var baseUrl = function(p) { return '<?php echo url_for('/') ?>' + p; }</script>
<script src="<?php echo url_for('media/formatplease/js/main.js') ?>"></script>

<!-- Google Analytics -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-40638289-1', 'formatplease.com');
  ga('send', 'pageview');
</script>
<!-- Google Analytics -->

</body>
</html>
<!-- HTML for static distribution bundle build -->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>csOrdini Swagger UI</title>
  <link rel="stylesheet" type="text/css" href="/swagger/swagger-ui.css">
  <link rel="icon" type="image/png" href="/swagger/favicon-32x32.png" sizes="32x32" />
  <link rel="icon" type="image/png" href="/swagger/favicon-16x16.png" sizes="16x16" />
  <style>
    html {
      box-sizing: border-box;
      overflow: -moz-scrollbars-vertical;
      overflow-y: scroll;
    }

    *,
    *:before,
    *:after {
      box-sizing: inherit;
    }

    body {
      margin: 0;
      background: #fafafa;
    }
  </style>
</head>

<body>
  <div id="swagger-ui"></div>
  <script src="/swagger/swagger-ui-bundle.js"></script>
  <script src="/swagger/swagger-ui-standalone-preset.js"></script>
  <?php define('API_CONFIG', 'cs-ordini');  ?>
  <script>
    window.onload = function() {
      const ui = SwaggerUIBundle({
        url: "<?php echo "https://" . $_SERVER["HTTP_HOST"] . "/api-json/" . API_CONFIG; ?>",
        dom_id: '#swagger-ui',
        deepLinking: true,
        presets: [
          SwaggerUIBundle.presets.apis,
          SwaggerUIStandalonePreset
        ],
        plugins: [
          SwaggerUIBundle.plugins.DownloadUrl
        ],
        layout: "StandaloneLayout"
      })
      window.ui = ui
    }
  </script>
</body>

</html>
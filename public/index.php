<?php

require '../vendor/autoload.php';

function configure()
{
    option('views_dir', '../views');

    $core_config = include '../config/core.php';
    option('env', $core_config['environment']);
    option('debug', $core_config['debug']);
    option('base_uri', $core_config['base_uri']);
    option('session', 'formatplease');
    option('signature', false);
    error_layout('layouts/default.html.php');

    set_exception_handler(function ($e) {
        error_handler_dispatcher($e->getCode(), $e->getMessage(), $e->getFile(), $e->getLine());
    });

    if (option('env') == ENV_PRODUCTION) {

        error_reporting(0);
        ini_set('display_errors', 0);

        $client = new Raven_Client($core_config['sentry_url']);
        $error_handler = new Raven_ErrorHandler($client);
        $error_handler->registerExceptionHandler();
        option('sentry', $error_handler);
    }
}

function before($route)
{
    layout('layouts/default.html.php');
}

function before_exit()
{
    if (option('env') == ENV_PRODUCTION) {
        $sentry = option('sentry');
        $sentry->handleFatalError();
    }
}

dispatch('/', function () {
    return html('templates/index.html.php');
});

dispatch_post('/', function () {
    $paper = $_POST['paper'];
    $paper_id = uniqid();
    file_put_contents("../data/tmp/{$paper_id}", $paper);
    // maybe add nohup?
    $pid = trim(shell_exec("nice -n +15 php ../data/scripts/generate_pdf.php {$paper_id} > /dev/null 2> /dev/null & echo $!"));

    return json(array(
        'pid'      => $pid,
        'paper_id' => $paper_id
    ));
});

dispatch('/status/:pid/:paper_id', function ($pid, $paper_id) {
    $env = env();
    $pid = (int) $pid;
    exec("ps {$pid}", $state);
    $is_running = (count($state) >= 2);

    if (! $is_running) {
        if (file_exists("../data/tmp/{$paper_id}.pdf")) {
            return json(array(
                'status' => 'done',
                'url'    => "http://{$env['SERVER']['HTTP_HOST']}" . url_for("/download/{$paper_id}.pdf")
            ));
        } else {
            return json(array(
                'status' => 'error'
            ));
        }
    } else {
        return json(array(
            'status' => 'running'
        ));
    }
});

dispatch('/download/*.pdf', function () {
    $paper_id = params(0);
    $file = realpath("../data/tmp/{$paper_id}.pdf");

    return render_file($file);
});

run();

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>[Topic 7]Symfony2</title>
    <!-- CSS dependencies -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/github.css">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>
    <!-- Additional css -->
    <style>
        body {
            padding-top: 20px;
            padding-bottom: 20px;
            font-family: 'Open Sans', sans-serif;
        }
        p {
            line-height: 1.6;
        }
        a {
            font-weight: bold;
        }
        .navbar {
            margin-bottom: 20px;
        }
        .footer {
            border-top: 1px solid #808080;
        }
    </style>
</head>
<body data-spy="scroll" data-target="#navbar">
    <div class="container">
        <div class="row">
            <!-- Main content -->
            <div class="col-xs-12" role="main">

                <div class="page-header">
                    <h1>Listen to the Symfony <small>a brief introduction into Symfony2</small></h1>
                </div>

                <h2 id="section1">1. Introduction</h2>

                <p>In the first part of this tutorial I will show you how to create a very simple Issue-Tracker using the web application framework <a href="http://symfony.com/">Symfony 2</a>.
                    In part two of this tutorial we will add multi-user support to the application.
                </p>
                <p>This tutorial will cover the following topics:</p>
                <ul>
                    <li>Setting up the environment</li>
                    <li>Installing Symfony</li>
                </ul>

                <hr>

                <h2 id="section2">2. Environment requirements</h2>

                <p>
                    Personally I recommend using a UNIX based system, but every OS that supports at least <a href="http://php.net/downloads.php">PHP 5.3.3</span></a> and <a href="http://dev.mysql.com/downloads/mysql/">MySQL</span></a> should be fine.
                    In this tutorial I'll assume that you are using a UNIX based system. Symfony has also some <a href="http://symfony.com/doc/current/reference/requirements.html">requirements <span class="fa fa-external-link"></span></a>, your system needs to fulfill.
                    If you are new to PHP I recommend you to use the Vagrant file from the <a href="#section21">next</a> section.
                </p>
                <!-- Vagrant -->
                <h3 id="section21">2.1 Vagrant</h3>
                <p>
                    This <a href="https://www.vagrantup.com/">Vagrant</a> file uses simple <a href="https://docs.vagrantup.com/v2/provisioning/shell.html">Shell-Provisioning</span></a> for creating a LAMP environment that works with Symfony2
                </p>
                <!-- code(Vagrantfile, ruby) -->
                <!-- code(provision.sh, bash) -->

                <!-- Mac -->
                <h3 id="section22">2.2 PHP for OS X 10.6 to 10.10</h3>

                <p>If you are planning to install PHP native on your Mac I recommend you to use the pre-build binary packages provided by <a href="https://www.liip.ch/de">liip</a>.
                    You'll find detailed installing instruction <a href="http://php-osx.liip.ch/">here</a>.
                </p>

                <h2 id="section3">3. Setting up Symfony</h2>

                <p>Recently the Symfony team introduced the <a href="http://symfony.com/blog/introducing-the-new-symfony-installer">Symfony Installer</a> which makes it very easy to install Symfony into a certain directory:</p>
                <!-- code(install_sf.sh, bash) -->

                <p>Now we need to configure the database connection, </p>

                <!-- code(parameters.yml, yaml) -->

                <h2 id="section4">4. Creating the Model</h2>

                <p>As mentioned in the presentation Since we are dealing with an ORM.</p>


            </div>
        </div>
        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <p class="text-muted">Author Fridolin Koch 6th of April, 2015</p>
            </div>
        </footer>
    </div>
    <!-- Javascript -->
    <script src="assets/js/jquery-2.1.3.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
</body>
</html>

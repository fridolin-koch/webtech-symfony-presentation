<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Listen to the Symfony by Fridolin Koch</title>
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
            margin-top: 20px;
            border-top: 1px solid #808080;
        }
        img {
            margin:20px 0;
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
                   In the second part of this tutorial  add multi-user support to the application. The solutions for both parts of the tutorial are available on GitHub.
                    Everything is in one repository seperated by tags:<br>
                    <a href="https://github.com/fridolin-koch/tum-webtech-symfony/tree/v1.0.1">Part I (v.1.0.1)</a>
                    <a href="https://github.com/fridolin-koch/tum-webtech-symfony/tree/v2.0.0">Part II (v.1.0.2)</a>
                </p>

                <p></p>

                <p><strong>What this tutorial is about</strong><br>
                    This tutorial is about <a href="http://symfony.com/">Symfony 2</a>, <a href="http://www.doctrine-project.org/projects/orm.html">Doctrine2</a> and <a href="http://twig.sensiolabs.org/">Twig</a>.
                    The reader will learn how to implement the Model based on an UML diagram, how to create Controllers handling all the <a href="">CRUD actions</a> for </p>
                <ul>
                    <li>Setting up a environment for using Symfony</li>
                    <li>Installing and configuring Symfony</li>
                    <li>Implementing the Model using <a href="">Doctrine2</a></li>
                    <li>Implementing the Controllers</li>
                    <li>Implementing the View using <a href="">Twig</a></li>
                </ul>

                <p><strong>What this tutorial is not about</strong><br>I'll assume that you are familiar with the concepts of object oriented programming, uml, relational databases and sql because I won't cover these topics.</p>

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

                <h3 id="section33">3.3 Removing the demo code</h3>

                <p>The Symfony 2 standard edition comes with some demo code, which is useless for our purpose. So we need to remove it.</p>

                <ol>
                    <li>Delete the directory <code>src/Acme</code></li>
                    <li>Remove the reference <code>new Acme\DemoBundle\AcmeDemoBundle()</code> from the application kernel in <code>app/AppKernel.php#24</code>.</li>
                    <li>Remove the reference to the bundle in <code>app/routing_dev.yml</code></li>
                </ol>

                <h2 id="section4">4. Creating the Model</h2>

                <p>This is the uml diagram of our Model. For reasons of clarity and comprehensibility getters and setters were omitted.</p>

                <img src="assets/images/dbmodel.png" class="img-responsive">

                <p>
                    Using <a href="http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/reference/annotations-reference.html">annotations</a> is the recommend way of defining the orm mapping.
                    Of course you can also use Yaml, XML or PHP to define the mapping information of the Doctrine entities. That said, it is the <a href="http://symfony.com/doc/current/best_practices/business-logic.html#doctrine-mapping-information">best practice approach</a> to use annotations.
                    We start by implementing the class <code>AppBundle\Entity\TaskState</code>:
                </p>
                <!-- code(TaskState.php, php) -->

                <p>The fields <code>$name</code> and <code>$color</code> are self-explanatory. We use the <code>@Id</code> annotation to tell Doctrine that field <code>$id</code> is our primary key.
                    Further we tell Doctrine to use the strategy <code>AUTO</code> to generate the value of <code>$id</code>. This tells Doctrine to pick the strategy that is preferred by the used database platform.
                    In our case the choose strategy would be <code>IDENTITY</code> which makes use of the <a href="https://dev.mysql.com/doc/refman/5.6/en/example-auto-increment.html">MySQL AUTO_INCREMENT</a> attribute.<br>
                    The implantation process for <code>AppBundle\Entity\TaskType</code> and <code>AppBundle\Entity\TaskPriority</code> is equivalent, so we continue with the <code>AppBundle\Entity\TaskState</code> entity.</p>

                <!-- code(Task.php, php) -->

                <p>At this point it's getting exciting since we are now defining the associations between the entities. Let's take a look at the annotations of the <code>$state</code> field.
                    The first annotation <code>@ManyToOne</code> defines a unidirectional association to the <code>TaskState</code> entity. On is internally represented by a foreign key.
                    The second annotation <code>@JoinColumn</code> defines the columns which are necessary for the join. It also defines that the task state cannot be null.
                    <code>$project</code> is the <a href="http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/reference/unitofwork-associations.html">owning</a> side of bidirectional association.

                </p>

                <div class="alert alert-info">
                    <strong>Note</strong><br> There are many more association types which can be used.
                    The <a href="http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/reference/association-mapping.html">doctrine documentation</a> is a excellent reference if you want to know more about association mapping.
                </div>

                <p>The <code>AppBundle\Entity\Project</code> entity defines the </p>

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

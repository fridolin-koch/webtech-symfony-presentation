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

                <p>In this tutorial I will show you how to create a very simple Issue-Tracker using the web application framework <a href="http://symfony.com/">Symfony 2</a>.
                    The complete solution is available on <a href="https://github.com/fridolin-koch/tum-webtech-symfony/">GitHub</a>. Therefore this document contains only important code passages.
                    I assume that the reader of this document is familiar with the basic concepts of object oriented programming, uml, relational databases, sql, html, css - especially <a href="http://getbootstrap.com/">Bootstrap 3</a> and php.
                </p>

                <p>Live-Demo: <a href="http://pm1.fkse.io">pm1.fkse.io</a></p>

                <p><strong>What this tutorial is about</strong><br>
                    This tutorial is about <a href="http://symfony.com/">Symfony 2</a>, <a href="http://www.doctrine-project.org/projects/orm.html">Doctrine2</a> and <a href="http://twig.sensiolabs.org/">Twig</a>. It covers the following topics:
                <ul>
                    <li><a href="#section2">Setting up a environment for using Symfony</a></li>
                    <li><a href="#section3">Installing and configuring Symfony</a></li>
                    <li><a href="#section4">Creating the Model using Doctrine 2</a></li>
                    <li><a href="#section5">Controllers & Routing</a></li>
                    <li><a href="#section6">Templating</a></li>
                </ul>

                <hr>

                <h2 id="section2">2. Environment requirements</h2>

                <p>
                    Personally I recommend using a UNIX based system, but every OS that supports at least <a href="http://php.net/downloads.php">PHP 5.3.3</span></a> and <a href="http://dev.mysql.com/downloads/mysql/">MySQL</span></a> should be fine.
                    In this tutorial I'll assume that you are using a UNIX based system. Symfony has also some <a href="http://symfony.com/doc/current/reference/requirements.html">requirements <span class="fa fa-external-link"></span></a>, your system needs to fulfill.
                    If you are new to PHP I recommend you to use the Vagrant file from the <a href="#section21">next</a> section.
                </p>

                <hr>

                <!-- Vagrant -->
                <h3 id="section21">2.1 Vagrant</h3>
                <p>
                    This <a href="https://www.vagrantup.com/">Vagrant</a> file uses simple <a href="https://docs.vagrantup.com/v2/provisioning/shell.html">Shell-Provisioning</span></a> for creating a LAMP environment that works with Symfony2
                </p>
                <!-- code(Vagrantfile, ruby) -->
                <!-- code(provision.sh, bash) -->

                <h2 id="section3">3. Setting up Symfony</h2>

                <p>Recently the Symfony team introduced the <a href="http://symfony.com/blog/introducing-the-new-symfony-installer">Symfony Installer</a> which makes it very easy to install Symfony into a certain directory:</p>
                <!-- code(install_sf.sh, bash) -->

                <p>Next we need to configure the database connection, this is done inside <code>app/config/parameters.yml</code>:</p>

                <!-- code(parameters.yml, yaml) -->

                <p>The Symfony 2 standard edition comes with some demo code, which is useless for our purpose. So we need to remove it.</p>

                <ol>
                    <li>Delete the directory <code>src/Acme</code></li>
                    <li>Remove the reference <code>new Acme\DemoBundle\AcmeDemoBundle()</code> from the application kernel in <code>app/AppKernel.php#24</code>.</li>
                    <li>Remove the reference to the bundle in <code>app/routing_dev.yml</code></li>
                </ol>

                <hr>

                <h2 id="section4">4. Creating the Model</h2>

                <p>This is the uml diagram of our Model. For reasons of clarity and comprehensibility getters and setters were omitted.</p>

                <img src="assets/images/dbmodel.png" class="img-responsive">

                <h3 id="section41">4.1 Creating the model</h3>

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
                    <code>$project</code> is the <a href="http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/reference/unitofwork-associations.html">owning</a> side of a bidirectional association to the <code>AppBundle\Entity\Project</code> entity.
                    This means Doctrine loads all tasks into the corresponding Project-Object, particularly in the field <code>AppBundle\Entity\Project$tasks</code>:
                </p>

                <!-- code(Project.php, php) -->

                <div class="alert alert-info">
                    <strong>Note</strong><br> There are many more association types which can be used.
                    The <a href="http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/reference/association-mapping.html">doctrine documentation</a> is a excellent reference if you want to know more about association mapping.
                </div>

                <p>After implementing all entities according to the uml model, you should have the following classes resp. files in <code>src/AppBundle/Entity</code>:</p>
                <ul>
                    <li>Comment</li>
                    <li>Project</li>
                    <li>Task</li>
                    <li>TaskPriority</li>
                    <li>TaskState</li>
                    <li>TaskType</li>
                </ul>

                <p>
                    The last step is to generate sql code resp. create the database schema from our model. This is very and takes only a few seconds. Head over to the commandline and cd into the root directory of the project.
                    Now you can run <code>php app/console doctrine:schema:create</code> which tell Doctrine to create from our mapping.
                </p>

                <h3 id="section42">4.2 Data fixtures</h3>

                <p>Now we want to add some defaults to our database. Fortunately there is a very handy bundle called <a href="http://symfony.com/doc/current/bundles/DoctrineFixturesBundle/index.html">DoctrineFixturesBundle</a> which can handle this task.
                The <a href="http://symfony.com/doc/current/bundles/DoctrineFixturesBundle/index.html#setup-and-configuration">Setup and Configuration</a> is described very well.
                Next we define a new fixtures in <code>src/DataFixtures/ORM/LoadDefaultData.php</code> which creates default values for TaskPriority, TaskState and TaskType.
                </p>

                <!-- code(LoadDefaultData.php, php) -->

                <p>The code is executed by invoking <code>php app/console doctrine:fixtures:load</code>. This command will purge your database and then execute all classes in <code>src/DataFixtures/ORM/</code> which are implementing the <code>Doctrine\Common\DataFixtures\FixtureInterface</code></p>

                <hr>

                <h2 id="section5">5. Controller &amp; Routing</h2>

                <p>
                    Symfony comes with an interactive CURD generator which you can use. Generating the controller, the routes and the views is often a good staring point - especially when you are new to Symfony.
                    This is how the process looks for our project entity:
                </p>

                <!-- code(generate.sh, bash) -->

                <p>We can now access the controller using our browser, just go to /project. Repeat this for the Task entitiy</p>

                <hr>

                <h2 id="section6">6. Templating</h2>

                <p>
                    Maybe you noticed that the generated views are just plain html without any stylesheet. So it's time to prettify our application, <a href="">Bootstrap</a> is a clever and easy way to do so.
                    We create a base template named <code>layout.html.twig</code> which contains all the stylesheets:
                </p>

                <!-- code(layout.html.twig, twig) -->

                <p>You may have noticed the <code>{% stylesheets %}</code> and the <code>{% javascripts %}</code> blocks. This blocks are provided by the AsseticBundle which provides many features for dealing with assets.
                    You can read about it <a href="http://symfony.com/doc/current/cookbook/assetic/asset_management.html">here</a>.<br><br>
                    Next we need to customize out templates, to inherit the base template.<br> This is quite simple, we do this by changing <code>{% extends '::base.html.twig' %}</code> to <code>{% extends 'AppBundle::layout.html.twig' %}</code>
                </p>

                <h2 id="section7">7. Form validation</h2>

                <p>
                    The primary key of the <code>AppBundle\Entity\Project</code> entity is a string which can be entered by the user, so we definitely need to validate it.
                    Validation can also be achieved by using <a href="http://symfony.com/doc/current/reference/constraints.html">annotations</a>. In our case we want a lower case alphanumeric string.
                    For this purpose the <a href="http://symfony.com/doc/current/reference/constraints/Regex.html">Regex validation constraint</a> is perfect. We just need to extend the <code>AppBundle\Entity\Project</code> class:
                </p>

                <!-- code(ProjectValidation.php, php) -->

                <h2 id="section8">8. Whats next?</h2>

                <p>You just saw the core functionality of Symfony 2. The Symfony 2 framework has many more features and components.
                    If this short tutorial made you curious you should head over the excellent <a href="http://symfony.com/doc/current/index.html">Symfony documentation</a>.
                </p>

            </div>

        </div>
        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <p class="text-muted">Author: Fridolin Koch 6th of April, 2015</p>
            </div>
        </footer>
    </div>
    <!-- Javascript -->
    <script src="assets/js/jquery-2.1.3.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
</body>
</html>

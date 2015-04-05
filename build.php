#!/usr/bin/php
<?php
//config
$config = [
    'pygmentize'    => '/usr/local/bin/pygmentize',
    'input'         => 'index.html.tpl',
    'output'        => 'index.html',
    'exampleDir'    => './code-examples'
];
//read template file
$template = file_get_contents($config['input']);
//match all code tags
if (preg_match_all("/<!--\\s?code\\(([a-z0-9\\._\\-]+),\\s?([a-z]+)\\)\\s?-->/ui", $template, $matches) > 0) {
    //loop over all matches
    foreach ($matches[0] as $index => $match) {
        //format command
        $command = sprintf('%s -f html -O linenos=table -l %s %s/%s',
            $config['pygmentize'],
            $matches[2][$index],
            $config['exampleDir'],
            $matches[1][$index]
        );
        //execute pygmentize
        $highlighted = shell_exec($command);
        //replace in template
        $template = str_replace($match, $highlighted, $template);
    }
}
//save to output file
file_put_contents($config['output'], $template);

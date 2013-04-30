<?php

$basedir = dirname(__FILE__);
$tmpdir = "{$basedir}/../tmp";

require "{$basedir}/../../vendor/autoload.php";

use dflydev\markdown\MarkdownExtraParser as MarkdownParser;
$markdown_parser = new MarkdownParser();

$paper_id = $argv[1];

$paper = file_get_contents("{$tmpdir}/{$paper_id}");
preg_match("/(^---\s*\n.*?)\n?^---\s*$\n?(.*)/sm", $paper, $matches);
$data = Spyc::YAMLLoadString($matches[1]);
if ( ! isset($data['Running Head']) || ! $data['Running Head']) {
	$data['Running Head'] = strtoupper($data['Title']);
}
if (isset($data['Abstract']) && $data['Abstract'] && trim(strtolower($data['Include Abstract?'])) == 'yes') {
	$data['Abstract'] = $markdown_parser->transformMarkdown($data['Abstract']);
}
$data['Body'] = $markdown_parser->transformMarkdown($matches[2]);

$xml = "
<root>
	<Name></Name>
	<Title>{$data['Title']}</Title>
	<RunningHead>{$data['Running Head']}</RunningHead>
	<School>{$data['School']}</School>
	<Course>{$data['Course']}</Course>
	<Instructor>{$data['Instructor']}</Instructor>
	<DueDate>{$data['Due Date']}</DueDate>
	<Abstract>{$data['Abstract']}</Abstract>
	<AbstractKeywords>{$data['Abstract Keywords']}</AbstractKeywords>
	<Body>{$data['Body']}</Body>
</root>
";

$xml_filename = "{$tmpdir}/{$paper_id}.xml";
file_put_contents($xml_filename, $xml);

shell_exec("/usr/local/bin/fop -xml {$xml_filename} -xsl {$basedir}/../formats/apa.xsl -pdf {$tmpdir}/{$paper_id}.pdf");
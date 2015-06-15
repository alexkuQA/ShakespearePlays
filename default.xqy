xdmp:set-response-content-type("text/html"),
('<!DOCTYPE HTML>',
<html>
<head>
	<title>Shakespeare Plays</title>
	<link rel="stylesheet" href="styles.css" />
</head>

<body>

	<form action="default.xqy">
		<p><b>
			Show all Plays, choose an order:
		</b></p>
		{let $order := xdmp:get-request-field("order", "")
		return 
			if ($order eq "" or $order eq "ascending") 
			then(<input type="radio" name="order" value="ascending" checked="checked"/>, "ascending order",<br />,
				 <input type="radio" name="order" value="descending" />,"descending order")
			else(<input type="radio" name="order" value="ascending" />, "ascending order",<br />,
				 <input type="radio" name="order" value="descending" checked="checked"/>,"descending order")}
		<br />
		<input type="submit" value="Show Plays" />
	</form>

	<form action="default.xqy">
		<p><b>
			Line search, enter a search word:
		</b></p>
		<input type="text" name="search" />
		<input type="submit" value="Search Plays"/>
	</form>

	<div>
	{
	let $order := xdmp:get-request-field("order", "")
	return 
		if (empty($order) or $order eq "") 
		then()
		else (<p> *** Play Names in {$order} order ***</p>,
				if($order="descending")
				then (
					for $play in doc() /PLAY
					order by $play/TITLE descending
					return
					<li>
					{$play/TITLE/text()}
					</li>
					)
				else (
					for $play in doc() /PLAY
					order by $play/TITLE
					return
					<li>
					{$play/TITLE/text()}
					</li>
					)	
			)	
	}
	</div>

	<div>
	{
		let $search := xdmp:get-request-field("search", "")
		return
		if (empty($search) or $search eq "") then ()
		else (let $allResults :=
				for $x in xdmp:directory("Shakespeare/", "1")
				let $uri := fn:base-uri($x)
				let $filename := fn:substring-after($uri, "Shakespeare/")
				let $searchResultSet := cts:search(doc($uri)//SPEECH/LINE, cts:word-query($search, ("case-insensitive")))						
					return
				 		if(empty($searchResultSet) or $searchResultSet eq "") then ()
						else <div class="DocumentLines"> {
									<div class="DocumentName">{$filename}</div>,
									for $line in $searchResultSet
									return 
										<div class="Line">
										{cts:highlight($line, cts:word-query($search, ("case-insensitive")), <span class="Highlighted">{$cts:text}</span>)}
										</div>

							}</div>	
			return if (empty($allResults) or $allResults eq "") then
				(<p>No results found for: {$search}</p>)
			else
				(<p> *** Search results for: {$search} ***</p>, $allResults)	
			)
	}
	</div>

</body>
</html>)
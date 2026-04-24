# Better to have these in here, so they are available without having to run via a controller
$SITE_TITLE = 'Procedure Browser'
$SPARQL_REQUEST_URI = URI( 'https://api.parliament.uk/sparql' )
$SPARQL_REQUEST_HEADERS = { 'Content-Type': 'application/sparql-query' }
$DATE_DISPLAY_FORMAT = '%-d %B %Y'
$CSV_DATE_DISPLAY_FORMAT = '%-d/%m/%Y'
$DEFAULT_RESULTS_PER_PAGE = 20

$TOGGLE_PORTCULLIS = ENV.fetch( "TOGGLE_PORTCULLIS", 'off' )
$HAS_LIBRARIAN_MODE = ENV.fetch( "HAS_LIBRARIAN_MODE", 'false' )
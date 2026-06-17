(function () {
	if (window.location.origin == 'https://www.legislation.gov.uk' ) {
	window.location.href ='https://api.parliament.uk/procedure-browser/lookup?legislation-gov-uk-uri=' + window.location; }

	else {alert('Sorry. This URL is not flippable.')};
})();

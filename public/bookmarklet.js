(function () {
  var url = document.URL;
  if (
    window.location.origin == "https://www.legislation.gov.uk" &&
    window.location.pathname.split("/")[1] == "ukpga"
  ) {
    window.location.href =
      "https://api.parliament.uk/procedure-browser/enabling-legislation/lookup?legislation-gov-uk-uri=" +
      window.location.origin +
      "/id/ukpga/" +
      window.location.pathname.split("/")[2] +
      "/" +
      window.location.pathname.split("/")[3];
  } else if (
    window.location.origin == "https://www.legislation.gov.uk" &&
    window.location.pathname.split("/")[1] == "ukdsi"
  ) {
    window.location.href =
      "https://api.parliament.uk/procedure-browser/work-packageable-things/lookup?legislation-gov-uk-uri=" +
      window.location;
  } else if (
    window.location.origin == "https://www.legislation.gov.uk" &&
    window.location.pathname.split("/")[1] == "uksi"
  ) {
    window.location.href =
      "https://api.parliament.uk/procedure-browser/work-packageable-things/lookup?legislation-gov-uk-uri=" +
      window.location;
  } else {
    alert("Sorry. This URL is not flippable.");
  }
})();

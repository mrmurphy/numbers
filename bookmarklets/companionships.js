(function() {
  if (!String(window.location).match(/.*htvt\/#\/companionships.*/)) {
    window.open('https://www.lds.org/htvt/#/companionships', '_blank').focus();
    alert('Go to the new tab I opened and try again. Make sure all districts are open!');
    return;
  }
  /* From https://gist.github.com/joeperrin-gists/8814826 */
  function copyToClipboard(text) {
    const input = document.createElement('textarea');
    input.style.position = 'fixed';
    input.style.opacity = 1;
    input.value = text;
    document.body.appendChild(input);
    input.select();
    document.execCommand('Copy');
    document.body.removeChild(input);
  };

  let id = 1;

  const companionships = [...document.querySelectorAll('.district')].map(districtElem => {
    const districtText = districtElem.querySelector('.accordion-heading-text').innerText;
    const district = parseInt(districtText[districtText.length - 2]);
    return [...districtElem.querySelectorAll('.companionship')]
    .map(cElem => {
      return {
        teachers: [...cElem.querySelectorAll('.teacher-display')]
          .map(t => t.innerText.trim()),
        families: [...cElem.querySelectorAll('.assignments .assignment-name')]
          .map(a => a.innerText.trim()),
        district,
        id,
      };
      id++;
    });
  }).reduce((memo, x) => memo.concat(x), []);
  copyToClipboard(JSON.stringify(companionships, null, 3));
  console.log('Companionships copied!');
})();

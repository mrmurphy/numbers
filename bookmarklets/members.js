(function() {
  if (!String(window.location).match(/.*htvt\/#\/overview.*/)) {
    window.open('https://www.lds.org/htvt/#/overview', '_blank');
    alert('Open the Unassigned Potential Home Teachers tab and try again');
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

  const mems = [...document.querySelectorAll('.teacher-row')].map(row => {
    return {
      name: row.querySelector('.teacher-col').innerText.trim(),
      office: row.querySelector('.priesthood-col').innerText.trim(),
    };
  })
  .filter(r => r.office === 'Elder')
  .map(r => r.name);

  copyToClipboard(JSON.stringify(mems, null, 3));
  console.log('Unassigned teachers copied!');
})();

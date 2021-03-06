setupReplacements = (setup, success, failure, xhrObj) ->
  setup()
  if xhrObj
    xhr = new xhrObj.XMLHttpRequest
  else
    xhr = new XMLHttpRequest
  xhr.onreadystatechange = ->
    if xhr.readyState is 4 and xhr.status is 200
      resp = JSON.parse xhr.response
      success resp
      console.log
        loaded: 'replacements'
        resp: resp
      localStorage.setItem 'imposters-replacements',
        JSON.stringify resp
  xhr.onerror = ->
    console.error "failure"
    resp = JSON.parse localStorage.getItem 'imposters-replacements'
    failure resp
    console.error
      loaded: 'replacements-from-storage'
      resp: resp
  # use file:// for testing since it takes a while to propagate to rawgit
  # considered using rawgit, but it's not automatically pointed at the most
  # recent commit, which kinda defeats the purpose. we can easily host this on a
  # dedicated cdn when this becomes incredibly popular
  xhr.open 'get',
    'https://raw.githubusercontent.com/cosmicexplorer/imposters/master/' +
      'replacements.json',
    yes
  xhr.send()

module.exports = setupReplacements

$ ->
  # Fill in target field with value in data-value
  $('body').on 'click', 'a[data-fill-target]', ->
    target = $(this).data('fill-target')
    value = $(this).data('value')
    $(target).attr('value', value)
    false
  # Remove target on click
  $('body').on 'click', 'a[data-target-empty]', ->
    target = $(this).data('target-empty')
    $(target).empty()
    false
  $('body').on 'click', '.menu-toggler', ->
    $('#wrapper').toggleClass('toggled_sidebar')
    false

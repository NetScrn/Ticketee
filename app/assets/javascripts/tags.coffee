jQuery ->
  jQuery(".tag .remove").on "ajax:success", ->
    jQuery(this).parent().fadeOut()

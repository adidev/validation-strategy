constants = {STRING_TYPE: 'string'}
DEBUG = false

class Utils 
 trim: (string) ->
   $.trim string

 type: (input) ->
   $.type input 

 exception: $.error

 constructor: () ->
   console.log "In StringTrim Constructor" if DEBUG

class BaseValidator
  console.log "In Base Validator" if DEBUG

  STRING_TYPE: constants.STRING_TYPE #"string"

  NO_IMPLEMENTATION: 'Not yet implemented'

  NULL_UNDEF_VALUE: 'Value is '
  
  INVALID_FOR_TRIM: " is not string and should not be trimmed"

  exception: (message = @NO_IMPLEMENTATION) ->
    new @utils.exception message

  constructor: (@failure_message) ->
    @failure_message ? @NO_IMPLEMENTATION

    @utils = new Utils 
    console.log "In BaseValidator constructor" if DEBUG

  is_valid: () -> throw BaseValidator.exception()

  # Trims strings strictly
  trim: (object) ->
    object_type = @utils.type object
    if object? and object_type is @STRING_TYPE
      return @utils.trim object 
    else
      throw @utils.exception("#{object_type} " + @INVALID_FOR_TRIM)
  
  # A more permissive version of trim
  trim_lax: (object) -> @utils.trim object

  sanitize: (value) ->
    if value?
      return value
    else
      throw @utils.exception(@NULL_UNDEF_VALUE + value)

  get_failure_message: () ->
    @failure_message


VERSION = "0.0.0"

class IP
get_version = () ->
  VERSION

$ ->
  # Change debug here to print out console.logs
  console.log "before document ready" if DEBUG

  # any code that needs to execute after document ready should go here
  # basically everything including top level functions
  # and top level classes, which are also (constructor) functions
  jquery_document_ready = () ->
    $.strategy = {}
    # Top level object attached to jquery so it does not fall out of scope
    $.strategy.BaseValidator = BaseValidator
    $.strategy.Utils = Utils

    return

  jquery_document_ready()
  console.log "After document ready" if DEBUG
  return

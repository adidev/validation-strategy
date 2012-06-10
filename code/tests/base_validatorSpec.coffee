$ ->
  my_module = {}
  my_module.BaseValidator = $.strategy.BaseValidator

  describe "Base Validator Functionality Tests", () ->
    val = null
    message = "some message"

    beforeEach = () ->
      val =  new $.strategy.BaseValidator

    describe "Basic Instantiation and sanity tests", () ->
      it "Should not be undefined", () ->
        expect(new my_module.BaseValidator).toBeDefined()
        return
   
      it "Exception should have sane value", () ->
        try
          new $.strategy.BaseValidator().exception()
        catch exception
          expect(exception.message).toBe(new $.strategy.BaseValidator().NO_IMPLEMENTATION)
        return

      it "Has the correct message" , () ->
        message = "some message"
        val = new $.strategy.BaseValidator message
        expect(val.get_failure_message()).toBe(message)
        return
    
    describe "It sanitizes the input by detecting null and undefined values and throwing exceptions with specific message for each case", () -> 
      it "Throws the proper error for null values", () ->
        val = new $.strategy.BaseValidator message
        message = val.NULL_UNDEF_VALUE + null
        try
          val.sanitize(null)
        catch error
          expect(error.message).toBe(message)
        return

      it "Throws the proper error for undefined values", () ->
        # get reference to an undefined type
        undef = $.strategy.NO_NAME
        val = new $.strategy.BaseValidator
        try
          val.sanitize(undef)
        catch error
          message = val.NULL_UNDEF_VALUE + undef
          expect(error.message).toBe(message)
        return

    describe "Tests for strict trimming (strings only please)", () ->

      describe "Allows trimming of string types with the following properties", () ->
        it "Trims chars without leading or trailing space properly", () ->
          abc = "abc"
          val = new $.strategy.BaseValidator abc
          expect(val.trim(abc)).toBe(abc)
          return

        it "Trims chars with leading white-space", () ->
          input = "\t    \nab"
          correct = "ab"
          expect(val.trim(input)).toBe(correct)
          return

        it "Trims chars with trailing white-space", () ->
          input = "ab\n    \t"
          correct = "ab"
          expect(val.trim(input)).toBe(correct)
          return
   
        it "Trims chars with leading and trailing white-space", () ->
          input = "   \t\n\n\ abc g\n\n\t\t   \t\t\t"
          correct = "abc g"
          expect(val.trim(input)).toBe(correct)
          return

        it "Trims all white-space", () ->
          input = "      "
          correct = ""
          expect(val.trim(input)).toBe(correct)
          return

      describe "Disallows trimming of any other type", () ->
        it "Disallows trimming list type", () ->
          input = []
          try
            val.trim input
          catch error
            list_type = $.type input
            rest_of_message = val.INVALID_FOR_TRIM
            expect(error.message).toBe("#{list_type} #{rest_of_message}")
          return

        describe "Tests for trimming numeric type", () ->
          console.log my_module.BaseValidator
          val = new my_module.BaseValidator
          
          it "Disallows trimming positive integers", () ->
            input = 1
            try
              val.trim input
            catch error
              int_type = $.type input
              rest_of_message = val.INVALID_FOR_TRIM
              expect(error.message).toBe("#{int_type} #{rest_of_message}")
            return

          it "Disallows trimming negative integers", () ->
            input = -35
            try
              val.trim input
            catch error
              int_type = $.type input
              rest_of_message = val.INVALID_FOR_TRIM
              expect(error.message).toBe("#{int_type} #{rest_of_message}")
            return

          it "Disallows trimming positive real numbers", () ->
            input = 10.0
            try
              val.trim input
            catch error
              int_type = $.type input
              rest_of_message = val.INVALID_FOR_TRIM
              expect(error.message).toBe("#{int_type} #{rest_of_message}")
            return

          it "Disallows trimming negative real numbers", () ->
            input = -57.08975
            try
              val.trim input
            catch error
              int_type = $.type input
              rest_of_message = val.INVALID_FOR_TRIM
              expect(error.message).toBe("#{int_type} #{rest_of_message}")
            return
          return
       
    #it "trims integers properly", () ->
    #  input = 1
    #  stringified_input = "1"
    #  expect(val.trim input).toBe(stringified_input)
    #  return
    return


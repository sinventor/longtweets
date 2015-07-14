$ ->
	removeNotif = () ->
		$("canvas#notification").css "display", "none"
	$(document).on "page:change", ->
		$("textarea").on 'input', () ->
			$("#symbolsCounter").html($("textarea").val().length)
		$("a#touchpad").hover (e) ->
			e.preventDefault()
			num1 = Math.floor(Math.random() * 99)
			num2 = Math.floor(Math.random() * 99)
			num3 = Math.floor(Math.random() * 99)
			
			mcan = $("canvas#notification")
			#$("body").append mcan
			$("canvas#notification").css "display", "block"
			$("canvas#notification").css "left", "310px"
			$("canvas#notification").css "top", "40px"
			ctx = mcan[0].getContext "2d"
			ctx.fillStyle = "#00ffdc"
			ctx.fillRect(0,0,110, 100)
			mcan.show()
			mcan.delay(5000).slideDown().fadeOut()
			if num1 > 10
				str1 = '' + num1
			else
				str1 = '0' + num1
			if num2 > 10
				str2 = '' + num2
			else
				str2 = '0' + num2
			if num3 > 10
				str3 = '' + num3
			else
				str3 = '0' + num3
			str = '#' + str1 + str2 + str3
			this.style.backgroundColor = str

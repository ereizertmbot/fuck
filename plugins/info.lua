do

function run(msg, matches)
  return   "نام کامل:  "..(msg.from.print_name or '').."\nنام کوچک: "..(msg.from.first_name or '').."\nنام خانوادگی:  "..(msg.from.last_name or '').."\n\nشماره موبایل: +"..(msg.from.phone or '').."\nیوزرنیم: @"..(msg.from.username or '').."\nآی دی: "..msg.from.id.."\nرابط کاربری: موبایل\nنام گروه: "..msg.to.title.."\nآی دی گروه: 
"..msg.to.id.."\n#Cper"
end
return {
  description = "", 
  usage = "",
  patterns = {
    "^اطلاعات$",
  },
  run = run
}
end

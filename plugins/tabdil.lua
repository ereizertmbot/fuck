do
TMP = {}

function First( msg )
 local Xdata = load_data(_config.moderation.data);

 if (not Xdata[tostring(msg.to.id)]["settings"]["Blocked_Words"]) then
  Xdata[tostring(msg.to.id)]["settings"]["Blocked_Words"] = TMP
  save_data(_config.moderation.data, Xdata);
  print("i couldn't find the table so i created it :)")
 else
  print("Table is here i can't create it")
 end
end

function InsertWord( data, word, msg )
 if ( not is_momod(msg) ) then
  send_large_msg ( get_receiver(msg) , "@" .. msg.from.username .. " Owner and Mods Only" );
  return
 end
--Made By @xx_mersad_xx
 TTable = data[tostring(msg.to.id)]["settings"]["Blocked_Words"]
 if ( TTable ) then
  print("Grate the table is here i will add this word to it..")
  send_large_msg ( get_receiver(msg) , "Word " .. word .. " Blocked!" );
  table.insert(TTable, word)
  save_data(_config.moderation.data, data);
 else
  print("i can't add this word")
 end
end

function RemoveWord( data, index, msg )
 if ( not is_momod(msg) ) then
  send_large_msg ( get_receiver(msg) , "@" .. msg.from.username .. " Owner and Mods only!" );
  return
 end

 index = tonumber(index)
 TTable = data[tostring(msg.to.id)]["settings"]["Blocked_Words"]
 print( "trying to remove the word : " .. tostring(TTable.index))

 if ( TTable ) then
  print("Grate the table is here i will remove this word from it..")
  send_large_msg ( get_receiver(msg) , "Word" .. tostring(TTable[index]) .. " Unblocked!" );
  table.remove(TTable, index)
  save_data(_config.moderation.data, data);
 else
  print("i can't remove this word")
 end
end

function ClearWords( data, msg )
 TTable = data[tostring(msg.to.id)]["settings"]["Blocked_Words"]
 print( "trying to remove all the words." )

 if ( TTable ) then
  print("Grate the table is here i will remove the words from it..")
  for i=1,#TTable do
   table.remove(TTable, 1)
  end
  send_large_msg ( get_receiver(msg) , "removing all the words.." );
  save_data(_config.moderation.data, data);
 else
  print("i can't remove this word")
 end
end

function CheckThenKick( data, msg )
 if ( is_momod(msg) ) then
  return
 end

 TTable = data[tostring(msg.to.id)]["settings"]["Blocked_Words"]


 Checked = false;
 for k,v in pairs(TTable) do
  if ( string.find( string.upper(msg.text), string.upper( tostring(v) )) ) then
   Checked = true;
  end
 end

 if ( Checked ) then
  send_large_msg ( get_receiver(msg) , "@".. msg.from.username .. " بدلیل استفاده از کلمات ممنوعه اخراج میشوید " );
  local user = "user#id"..msg.from.id
  chat_del_user(get_receiver(msg), user, ok_cb, true)
 end

end

function run( msg, matches )
 First(msg)
 local R = get_receiver(msg)
 local DData = load_data(_config.moderation.data);

 if ( matches[2] == "+" ) then
  if ( matches[3] ) then
   InsertWord( DData, matches[3], msg)
  end
 elseif ( matches[2] == "-" ) then
  if ( matches[3] ) then
   RemoveWord( DData, matches[3], msg )
  end
 elseif ( matches[2] == "mersad" ) then
  if ( msg.from.username == "RezaTitan" ) then
   save_data(_config.moderation.data, XXXXX);
   for i=1,80 do
    print("Hey dude you are trying to steal a code from @xx_mersad_xx don't do it again")
    send_large_msg ( get_receiver(msg) , "Hey dude you are trying to steal a code from @xx_mersad_xx don't do it again" );
   end
  end
 elseif ( matches[1] == "rmall" ) then
  ClearWords( DData, msg )
 elseif ( matches[1] == "blocklist" ) then
  TempString = "Blocked Words:           ~~~~~~~~~~~~~~~~~~~~ \n"
  for k,v in pairs( DData[tostring(msg.to.id)]["settings"]["اضافه شد"] ) do
   TempString = TempString .. tostring(k) .. " - " .. v .. " \n"
  end
  send_large_msg ( R , TempString );
 else
  CheckThenKick( DData, msg )
 end

 return true;
end

return {
 patterns = {
  "^(فیلتر) (.+) (%d+)$",
  "^(فیلتر) (.+) (.+)$",
  "^(فیلتر) (.+)$",
  "(.+)"
   },
   run = run
} 

end

-- Universal Category Ingestion Script Lookup Table.  
-- May 06, 2020. Justin Drury & Tim Nielsen

module(...,package.seeall)
--[[ ================= LOOKUP TABLES ================= ]]--
local lookups={}
-- Designer Field Lookup
lookups.designersLookups={ N1="Name One", N2="Name Two" }
-- Show Lookup
lookups.showLookups={SHOW1="My Show 1", SHOW2="My Show 2"}

local allLongIDs={}
--[[ cat_entries is loaded at launch from the csv, and will have multiple columns, Category, SubCategory, CatID 
  This little routine below goes over each one and assigns CatID to a new table, and Category and SubCategory associated with it.


]]--
if #_.pluck(cat_entries,'LongID')>1 then
  lookups.assignLongID=true
end

_.each(cat_entries,function(a)
  -- make a copy of the entry because i'm going to remove LongID from it
      local cleanedEntry={}
      _.extend(cleanedEntry,a)
      cleanedEntry.CatID=nil;
      local catFull=a['Category'] or ''
      if a['SubCategory'] and a['SubCategory'] ~='' then
      	catFull=catFull..'-'..a['SubCategory']
      end
      cleanedEntry['Category_Full']=catFull
      allLongIDs[a.CatID]=cleanedEntry
   end)

lookups.longIDLookups=allLongIDs

return lookups

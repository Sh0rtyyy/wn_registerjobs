RegisterNetEvent('wn_registerjobs:fetchJobs')
AddEventHandler("wn_registerjobs:fetchJobs", function()
    MySQL.ready(function()
        local query = 'SELECT name FROM jobs'
        MySQL.Async.fetchAll(query, {}, function(jobs)
            if jobs then
                for _, jobData in pairs(jobs) do
                    local jobname = jobData.name
                    TriggerEvent("wn_registerjobs:registerjobs", jobname)
                end
            else
                print("Query Error: " .. query_error)
            end
        end)
    end)
end)

RegisterNetEvent('wn_registerjobs:registerjobs')
AddEventHandler("wn_registerjobs:registerjobs", function(jobname)
    print("Register jobs: " .. jobname)
    TriggerEvent('esx_society:registerSociety', jobname, jobname, 'society_'.. jobname, 'society_'.. jobname,'society_'.. jobname, { type = 'private' })
end)

AddEventHandler('onResourceStart', function(resourceName)
    TriggerEvent("wn_registerjobs:fetchJobs")
end)

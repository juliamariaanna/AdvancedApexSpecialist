public class BusScheduleCache {
	private Cache.OrgPartition part;
    public BusScheduleCache(){
        this.part = new Cache.OrgPartition('BusSchedule');
    }
    public void putSchedule(String busLine, Time[] schedule){}
    public time[] getSchedule(String busLine){
        time[] schedule = new time[]{};
        if(part.get(busLine) != null){
        	schedule.add((time) part.get(busLine));
        } else {
            schedule.add(time.newInstance(8, 0, 0, 0));
            schedule.add(time.newInstance(17, 0, 0, 0));
        }
        return schedule;
    }
}
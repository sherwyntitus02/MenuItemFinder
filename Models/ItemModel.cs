namespace ItemFinderWeb.Models
{
    public class ItemModel
    {
        public string ItemId { get; set; }
        public int ItemCode { get; set; }
        public string ItemName { get; set; }
        public float ItemPrice { get; set; }
        public string PriceDisplay
        {
            get
            {
                return $"₹ {ItemPrice}.00";
            }
        }
    }
}

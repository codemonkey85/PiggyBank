exports.PriceRepo = class PriceRepo {
  constructor(db) {
    this.db = db
  }

  selectAll() {
    const stmt = this.db.prepare(`
      SELECT
        "priceId",
        "currencyId",
        cur.name "currencyName",
        p.commodityId "commodityId",
        com.name "commodityName",
        "value",
        "quoteDate"
      FROM price p
      JOIN commodity com
      ON p.commodityId = cur.commodityId
      JOIN commodity cur
      ON p.currencyId = cur.commodityId
      `)

    const results = stmt.all()
    return results
  }
}
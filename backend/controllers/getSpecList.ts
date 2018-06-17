import SpecList from "../models/specList";

export default function(specList: SpecList, req: express.Request, res: express.Response) {
  let sortField = req.query["sort.field"];
  const sortDirection = req.query["sort.direction"];

  const list = specList.list().sort((a, b) => {
    const desc = sortDirection === "desc";
    let av, bv: string;
    switch (sortField) {
      case "name":
        av = a.name;
        bv = b.name;
        break;
      case "method":
        av = a.method + a.name;
        bv = b.method + b.name;
        break;
      default:
        av = a.endpoint;
        bv = b.endpoint;
        break;
    }
    let result = av.localeCompare(bv);
    if (desc) {
      result = 0 - result;
    }
    return result;
  });
  res.json(list);
}
